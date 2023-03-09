#!/bin/bash

#SBATCH --array=1-70
#SBATCH --nodes=1
#SBATCH -c 1   

python scripts_october/permutational.py ${SLURM_ARRAY_TASK_ID}
