#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --mail-user=savouriess2112@gmail.com

mkdir -p maf_extraction4
mkdir -p results_SNP

for value in fixed_inno 
do
    echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed" > results_SNP/$value.bed
    cat intervals_by_chrom/$value* | awk 'NF{NF--};1'| while read chrom start stop;
        do
        ans="${value} ${chrom} ${start} ${stop}"
        srun --nodes 1 scripts_october/extr.sh $ans
        done
done
wait