#!/bin/bash

#SBATCH -J hello
#SBATCH --array=1-3131                   # how many tasks in the array 313159295
#SBATCH -c 1                            # one CPU core per task
#SBATCH -o output/hello-%j-%a.out
#SBATCH --nodes=5-10
#SBATCH --mail-type=ALL
#SBATCH --mail-user=savouriess2112@gmail.com

mkdir -p maf_extraction4
mkdir -p results_SNP2

#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/two_alleles.bed
#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_inno.bed
#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_noninno.bed

srun scripts_october/hello.sh $SLURM_ARRAY_TASK_ID