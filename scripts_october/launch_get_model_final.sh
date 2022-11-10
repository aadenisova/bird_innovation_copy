#!/bin/bash

dir=$1
tree=$2
new_dir=$3

mkdir -p models_by_chrom
mkdir models_by_chrom/$new_dir


for chrom in $(ls $dir)
do
        sbatch -c 16 -n 1 -p vgl scripts_october/get_model_final.sh $chrom $dir $tree $new_dir
done
