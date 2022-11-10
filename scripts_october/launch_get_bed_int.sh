#!/bin/bash

mkdir -p intervals_by_chrom

for chrom in $(ls wig_by_chrom2/maf_8sp/)
do
	python scripts_october/get_bed_int.py $chrom wig_by_chrom2/ wig_by_chrom_final2/ intervals_by_chrom 
done