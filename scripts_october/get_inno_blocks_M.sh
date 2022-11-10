#!bin/bash
file_name=$1 
dir_name=$2 #with /
job_id=$(sbatch -c 32 -n 1 -p vgl scripts_october/get_int_t.sh ${file_name} ${dir_name}| cut -d ' ' -f4)
job_id2=$(sbatch --dependency=afterok:${job_id} -c 32 -n 1 -p vgl scripts_october/launch_mafratio.sh ${dir_name} maf_ratio_strict.py)
echo "$job_id2"

