##########################################
## executable pathnames
#set AIRPATH =  /usr/local/pkg/AIR3.08
#set AFNIPATH =  /usr/local/pkg/afni_2010
#set TOOLSPATH =  /usr/local/pkg/tools/bin
#set FSLPATH =  /usr/local/pkg/fsl/bin
#set NISPATH = /usr/local/pkg/nis/bin
#set STATPATH =  /usr/local/pkg/stat/bin
############################################

#JW if running in csh you might have to run this command
setenv DYLD_FALLBACK_LIBRARY_PATH /opt/X11/lib:/usr/local/ni_tools/afni

#thresh for current model
#PEChosen - 0.001 --  0.0001 -- 4.278 
#RewMag -
#Value -



cd /Volumes/bek/learn/grpanalysis/working_group_analysis
set imgname =  tt++Value  # take grp map of interest
set p = 0001
set brick = 1  # contrast of interest, e.g. value, PE, reward magnitude JW:(t-stat)
set thresh = 4.268 #t-value at the p, look up
set mask = mni_icbm152_t1_tal_nlin_asym_09c_mask_2.3mm.nii #do we need to cp it? 
#set mask = vmPFC
#set mask = striatum_rev
#set GMimgname = ${imgname}
#set GMimgname = ${imgname}in${mask}


3dcalc -prefix ${imgname}p${p} -expr "a*astep(a,${thresh})" -a ${imgname}+tlrc"[${brick}]"
3dcalc -prefix ${imgname}_masked_p${p} -expr "a*step(b)" -a ${imgname}p${p}+tlrc -b ${mask}
3dClustSim -mask "${mask}" -nxyz 84 100 84 -dxyz 2.3 2.3 2.3 -acf .56 4.82 16.04 -pthr 0.001 .0001 -iter 1000 
# without nxyz
3dClustSim -mask "${mask}" -dxyz 2.3 2.3 2.3 -acf .56 4.82 16.04 -pthr 0.001 .0001 -iter 1000 #JW: replace fwhm with acf outputting by fwhmx?


#  extract significant clusters, label them sequentially from biggest to smallest
#  use 3.125*3.125*3.0=29 mm^3 per voxel


mkdir clusterinfo
set clustersize = 20.1 #From 0.001 -NN1 pthr at alpha .05000
@ vmul = $clustersize * 12.167 # 3^3 = the volume of a single voxel
3dclust -prefix "${imgname}_maskedp${p}c${clustersize}bin" -savemask ${imgname}_maskedp${p}c${clustersize}bin.numbered -verbose 3 ${vmul} "${imgname}_masked_p${p}+tlrc" >  ./clusterinfo/${imgname}_maskedp${p}c${clustersize}bin.out.1D

nedit ./clusterinfo/${imgname}_maskedp${p}c${clustersize}bin.out.1D


#find where each centroid is located in brain atlases
whereami -coord_file ./clusterinfo/${imgname}_maskedp${p}c${clustersize}bin.out.1D'[1,2,3]' -lpi -space MNI -tab > ./clusterinfo/${imgname}_maskedp${p}c${clustersize}centroidinfo_MNI.txt

#find what % of numberedroi clusters are located in which regions
whereami -omask ${imgname}_maskedp${p}c${clustersize}bin.numbered+tlrc -lpi -dset MNI -tab > ./clusterinfo/${imgname}_maskedp${p}c${clustersize}clusterinfo_MNI.txt
nedit ./clusterinfo/${imgname}_maskedp${p}c${clustersize}clusterinfo_MNI.txt
