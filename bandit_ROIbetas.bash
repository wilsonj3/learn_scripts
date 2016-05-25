#!/bin/bash


#$1 path to single subject files
#$2 regressor name
#$3 mask

pathtosearch="${1}"
  
set -e
files=($( find "$pathtosearch" -iname "banditStakeValueRewMag*+tlrc.HEAD" -type f ))
echo ${files[@]}

sub_bricks=($( 3dinfo -verb ${files[@]} | grep -i "${2}#0_Coef" | perl -pe 's/^.*At sub-brick #(\d+) .*/\1/' ))

echo ${sub_bricks[@]}

file_bricks=
for ((i=0; i < ${#files[@]}; i++)); do
	file_bricks="${file_bricks} ${files[i]}[${sub_bricks[i]}]"
done

echo $file_bricks

3dROIstats -1DRformat -mask /Volumes/bek/learn/grpanalysis/working_group_analysis/masksP001/${3}.numbered+tlrc.BRIK.gz $file_bricks > betas_${2}.txt

sed -i .bak 's|/Volumes[^0-9]*||g' betas_${2}.txt
sed -i .bak 's/_Zscored//g' betas_${2}.txt
sed -i .bak 's/\+t.*]//g' betas_${2}.txt
sed -i .bak "s/Mean_/${2}/g" betas_${2}.txt

#Remove back up file
rm *.bak

