#!/bin/bash

#SBATCH -J hello
#SBATCH --array=1-100                   # how many tasks in the array 24749
#SBATCH -c 1                            # one CPU core per task
#SBATCH --nodes=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=savouriess2112@gmail.com

PER_TASK=$1 #71
#filename=$2

START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))

for (( run=$START_NUM; run<=$END_NUM; run++ )); do
    . scripts_october/hello_big.sh $run 
done