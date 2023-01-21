#!/bin/bash

chrom=$1
start=$2
stop=$3
i=$4

filename="${chrom::-4}_${start}_${stop}_${i}.maf"
mafExtractor --maf maf_by_chrom/maf_8sp/$chrom --seq GCF_003957565.2_bTaeGut1.4.pri.${chrom::-4} \
--start $start --stop $stop > december/maf_extraction/$filename

bed_name="${chrom::-4}.bed"
python scripts_october/maf_ratio_.py december/maf_extraction/ $filename >> december/conservative_by_chrom/$bed_name

rm $filename