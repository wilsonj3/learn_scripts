#My attempt to use gen_group_command.py
   
#Arg 1 = prefix Ex: 3dMEMA_PREFIX+tlrc.BRIK.gz 
#Arg 2 = sub betas eg "#14 valueChosenDiffDecAligned#0_Coef"


#Arg 3  = sub tstats eg "#16 valueChosenDiffDecAligned_Fstat"
#Arg 4 = bucket label Ex: banditNoRewardCensored only has to be part of the string but be careful here...

#Quick arg check
if [ $# -lt 3 ]; then
  echo 1>&2 "$0: not enough arguments"
  exit 2
elif [ $# -gt 3 ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi


gen_group_command.py -command 3dMEMA \
                     -dsets /Volumes/bek/learn/ssanalysis/bandit/3dREMLfit_output/with_tout/*REML+tlrc.HEAD \
		     -write_script .tmp \
		     -prefix 3dMEMA_$1 \
		     -subs_betas $2 \
      		     -subs_tstats $3 \
		     -verb 1\
		     -options \
		     -cio -jobs 12 -max_zeros 4 \
		     		    		     
#Remoe the .HEAD part of the file add #!/bin/csh to top of file 
sed -e 's/.HEAD//g' .tmp > cmd.3dMEMA.4
echo '#!/bin/csh' | cat - cmd.3dMEMA.4 > temp_text && mv temp_text cmd.3dMEMA.4

#Run command
chmod 775 cmd.3dMEMA.4
./cmd.3dMEMA.4

#Move output to group analysis dir
#mv *+tlrc.* ../grpanalysis/working_group_analysis/
