#!/bin/bash

mkdir -p wig_by_chrom_final2

for dir in $(ls wig_by_chrom2)
do
	mkdir -p wig_by_chrom_final2/$dir
	for file in $(ls wig_by_chrom2/$dir)
	do
		grep -v 'fixedStep' wig_by_chrom2/$dir/$file > wig_by_chrom_final2/$dir/$file
	done
done 
