#!/bin/bash
model=$1
maf=$2
result=$3
method=$4

phyloP --method $method --mode CON \
--wig $model $maf > wig_by_chrom/noninno3/$result
