#!/bin/bash
i=$1

string=$(sed "${i}q;d" intervals_cated/all2.bed)

chrom=$(echo  $string | awk '{print $1}')
start=$(echo  $string | awk '{print $2}')
stop=$(echo  $string | awk '{print $3}')
value=$(echo  $string | awk '{print $5}')

scripts_october/extract_process.sh $value $chrom $start $stop