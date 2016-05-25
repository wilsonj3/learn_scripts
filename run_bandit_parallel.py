import subprocess
import os
import time
import shlex

#Perhaps in run_bandit_ssa_model we add in an arg where that is the outdir and if it doesn't exist create it...


#Read in list of ids
with open('bandit_subject_list') as id_file:
	id_list = id_file.read().splitlines()

#Close up the file
id_file.close()

#Max number of workers
max_processes = 10

#This is the commnd needed to be ran
command = './run_bandit_ssa_model.csh'

processes = set()

#Execute up to max_processes jobs at a time
for id in id_list:
	processes.add(subprocess.Popen([command, id]))
	if len(processes) >= max_processes:
		os.wait()
		processes.difference_update([p for p in processes if p.poll() is not None])

