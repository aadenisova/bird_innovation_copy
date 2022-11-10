#!/bin/bash
model=$1
maf=$2
result=$3
method=$4

phyloP --method $method --mode CON --wig $model $maf > wig_by_chrom/all/$result #--branch GCA_008658365,GCA_014839755,GCF_003957565,GCA_009819605,GCA_009819655,GCA_009764595 

