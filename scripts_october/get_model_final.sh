#!/bin/bash

maf_file=$1
dir=$2
tree=$3
new_dir=$4

mkdir -p models_by_chrom/$new_dir

phyloFit --tree $tree --subst-mod REV \
$dir/$maf_file --out-root models_by_chrom/$new_dir/$maf_file
