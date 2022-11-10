#!/bin/bash
model=$1
maf=$2
result=$3
method=$4

phyloP --method $method --mode CON --branch GCA_008658365,GCA_014839755,GCF_003957565 \
--wig $model $maf > wig_by_chrom/noninno/$result
