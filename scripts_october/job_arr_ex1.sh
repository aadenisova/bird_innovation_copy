#!/bin/bash

#SBATCH -J hello
#SBATCH --array=1-100%25               # how many tasks in the array 313159295 313112097 4000001 3131    
#SBATCH -c 1                            # one CPU core per task
#SBATCH -o output2/hello-%j-%a.out
#SBATCH -p vgl
#SBATCH --nodes=5-7
#SBATCH --mail-type=ALL
#SBATCH --mail-user=savouriess2112@gmail.com

mkdir -p maf_extraction5
mkdir -p results_SNP2

echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/two_alleles2.bed
#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_inno.bed
#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_noninno.bed

#Set the number of runs that each SLURM task should do
PER_TASK=248

# Calculate the starting and ending values for this task based
# on the SLURM task and the number of runs per task.
START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))

for (( run=$START_NUM; run<=$END_NUM; run++ )); do
  srun scripts_october/hello.sh $run
done