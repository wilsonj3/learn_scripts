#!/bin/csh
##########################################
## executable pathnames
#set AIRPATH =  /usr/local/pkg/AIR3.08
#set AFNIPATH =  /usr/local/pkg/afni_2010
#set TOOLSPATH =  /usr/local/pkg/tools/bin
#set FSLPATH =  /usr/local/pkg/fsl/bin
#set NISPATH = /usr/local/pkg/nis/bin
#set STATPATH =  /usr/local/pkg/stat/bin
############################################


set time_stamp = `t_testTest`
#mkdir "/Volumes/bek/learn/grpanalysis/${time_stamp}"

#foreach line ("`cat bandit_subjectlist`" )
#echo $line
#set id = ($line)
#echo $id

#chdir /Volumes/bek/learn/grpanalysis/${time_stamp}
#set funcpath = /Volumes/bek/learn/MR_Proc/*${id}*/bandit_MB_proc/


foreach line ( "`cat bandit_subject_list`" )
  set id = ($line)
  echo $id
  set pre = "/Volumes/bek/learn/ssanalysis/bandit/useThis/"
  set po = "bandit_dec_feed_value_posnegPEs_motor_${id}+tlrc"
  set t=8
  echo ${pre}${po}"[${t}] \" >> tmp_file
end


set t=8
chdir /Volumes/bek/learn/grpanalysis/t_testTest
   
#t-test for subjects so far
   set pre = "/Volumes/bek/learn/ssanalysis/bandit/useThis/bandit_dec_feed_value_posnegPEs_motor_"
   set po = "+tlrc" 
   /usr/local/ni_tools/afni/3dttest -prefix valueDiffPEs -base1 0 -set2 \
   ${pre}115105${po}"[${t}]" ${pre}204015${po}"[${t}]"  ${pre}208510${po}"[${t}]" \
   ${pre}208572${po}"[${t}]" ${pre}209662${po}"[${t}]" \
   
   
   
   #/usr/local/ni_tools/afni/3dttest++ -setA \
   #/Volumes/bek/learn/scripts/test_file
   
   #set pre = "/Volumes/bek/learn/ssanalysis/bandit/useThis/bandit_dec_feed_value_posnegPEs_motor_"
   #set po = "+tlrc" 
   #/usr/local/ni_tools/afni/3dttest -prefix alex_peMinus -base1 0 -set2 \
   #${pre}115105${po}"[${t}]" ${pre}204015${po}"[${t}]"  ${pre}208510${po}"[${t}]" \
   #${pre}208572${po}"[${t}]" ${pre}209662${po}"[${t}]" \
   


rm /Volumes/bek/learn/scripts/tmp_file
