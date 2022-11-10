#!/bin/bash
model=$1
maf=$2
result=$3
method=$4

phyloP --method $method --mode CON --branch GCA_009819605,GCA_009819655,GCA_009764595 \
--wig $model $maf > wig_by_chrom/inno/$result

