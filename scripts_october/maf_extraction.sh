#!/bin/bash
mkdir -p maf_extraction
cat intervals_by_chrom/* | while read chrom start stop type int;
do
        filename="${chrom}_${type}_${start}_${stop}.maf"
        mafExtractor --maf maf_by_chrom/maf_8sp/$chrom --seq GCF_003957565.2_bTaeGut1.4.pri.${chrom::-4} \
        --start $start --stop $stop > maf_extraction/$filename
       	#echo $filename
	#echo $type 
done

