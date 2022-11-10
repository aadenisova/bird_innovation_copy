#!/bin/bash

new_dir=$1
dir=$2

mkdir $new_dir
cd $new_dir
mkdir noninno3
cd ../

for chrom in $(ls $dir)
do
        sbatch -c 16 -n 1 -p vgl scripts_october/get_model_3.sh $chrom $dir
done
