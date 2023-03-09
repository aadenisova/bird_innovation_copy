#!/bin/bash

value=$1
chrom=$2
chrom="${chrom::-6}"
start=$3
stop=$4
i=$5

filename="${value}_${chrom::-4}_${start}_${stop}_${i}.maf"
mafExtractor --maf maf_by_chrom/maf_8sp/$chrom --seq GCF_003957565.2_bTaeGut1.4.pri.${chrom::-4} \
--start $start --stop $stop > december/maf_extraction_0/$filename

python scripts_october/maf_ratio_.py december/maf_extraction_0/ $filename >> december/$value.bed

mafExtractor --maf maf_by_chrom/maf_8sp/NC_044211.2.maf --seq GCF_003957565.2_bTaeGut1.4.pri.NC_044211.2 \
--start 19261802 --stop 19261802 