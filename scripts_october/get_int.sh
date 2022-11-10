#!/bin/bash
file=$1
dir=$2
chrom=$3

mkdir -p $dir
cat $file | while read name start stop int;
do
        filename="inno_${start}_${stop}.maf"
        mafExtractor --maf maf_by_chrom/$chrom.maf \
	--seq GCF_003957565.2_bTaeGut1.4.pri.$chrom \
	--start $start --stop $stop > $dir/$filename
        echo $filename
done

