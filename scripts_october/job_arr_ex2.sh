#!/bin/bash

#SBATCH -J hello
#SBATCH --array=1-1000%100                   # how many tasks in the array 24749
#SBATCH -c 1                            # one CPU core per task
#SBATCH -o output2/hello-%j-%a.out
#SBATCH --nodes=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=savouriess2112@gmail.com

#mkdir -p maf_extraction6
#mkdir -p results_SNP2

#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed\tindex\tn_genomes\tRef_inno\tAlt_noninno\t" > december/fixed_inno.bed #results_SNP2/two_alleles4.bed
#$value=fixed_inno_all.bed

#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_inno.bed
#echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP2/fixed_noninno.bed

PER_TASK=$1 #9161303
filename=$2

START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))

for (( run=$START_NUM; run<=$END_NUM; run++ )); do
    . scripts_october/hello.sh $run $filename #fixed_inno_all.bed
done