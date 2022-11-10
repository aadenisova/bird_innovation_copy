#!/bin/bash
mkdir maf_by_chrom_3sp

list_of_chrom=$1
align_hal=$2

for chrom in $(less $list_of_chrom)
do
sbatch -c 16 -n 1 -p vgl scripts_october/to_maf.sh GCF_003957565.2_bTaeGut1.4.pri \
$chrom GCF_003957565.2_bTaeGut1.4.pri,GCA_008658365.1_bAlcTor1_primary,GCA_014839755.1_bSylBor1.pri \
maf_by_chrom_3sp/$chrom.maf $align_hal
done
