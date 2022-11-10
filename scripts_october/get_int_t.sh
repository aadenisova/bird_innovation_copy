#!/bin/bash
file=$1
dir=$2
mkdir -p $dir
cat $file | while read name start stop int;
do
	filename="inno_${start}_${stop}.maf"
	mafExtractor --maf ../test4C_NC_044219.2.maf --seq GCF_003957565.2_bTaeGut1.4.pri.NC_044219.2 \
	--start $start-1 --stop $stop+1 > $dir/$filename
	echo $filename
done

