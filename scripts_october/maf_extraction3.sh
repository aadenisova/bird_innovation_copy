#!/bin/bash
mkdir -p maf_extraction3

for value in fixed_inno fixed_noninno two_alleles
do
    cat intervals_by_chrom/$value* | while read chrom start stop int;
        do
                filename="${value}_${chrom::-4}_${start}.maf"
                mafExtractor --maf maf_by_chrom/maf_8sp/$chrom --seq GCF_003957565.2_bTaeGut1.4.pri.${chrom::-4} \
                --start $start --stop $stop > maf_extraction3/$filename
        done
done