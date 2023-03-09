#!/bin/bash
i=$1

string=$(tail -n+2 positions_with_genes.tsv | sed "${i}q;d")

chrom=$(echo  $string | awk '{print $1}')
start=$(echo  $string | awk '{print $4}')
stop=$(echo  $string | awk '{print $4}')
value=$(echo  $string | awk '{print $2}')
gene=$(echo  $string | awk '{print $3}')
#gene=$(echo  $string | awk '{print $11}')

scripts_october/extract_process_big.sh $i $chrom $start $stop $value $gene