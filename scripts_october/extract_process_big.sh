#!/bin/bash

i=$1
chrom=$2
#chrom="${chrom::-6}"
start=$3
stop=$4
value=$5
gene=$6

filename="${value}_${chrom}_${start}_${stop}_${i}_${gene}.maf"
mafExtractor --maf maf_by_chrom_big/$chrom.maf --seq GCF_003957565.2_bTaeGut1.4.pri.$chrom \
--start $start --stop $stop > sp_cactus/maf_extraction_big/$filename

python scripts_october/maf_ratio_.py sp_cactus/maf_extraction_big/ $filename >> sp_cactus/bed_results/all_cactus.bed