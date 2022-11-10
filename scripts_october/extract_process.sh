#!/bin/bash

value=$1
chrom=$2
start=$3
stop=$4

filename="${value}_${chrom::-4}_${start}_${stop}.maf"
mafExtractor --maf maf_by_chrom/maf_8sp/$chrom --seq GCF_003957565.2_bTaeGut1.4.pri.${chrom::-4} \
--start $start --stop $stop > maf_extraction4/$filename

python scripts_october/maf_ratio_.py maf_extraction4/ $filename >> results_SNP2/$value.bed