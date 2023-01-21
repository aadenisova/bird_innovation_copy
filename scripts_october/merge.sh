#!/bin/bash

wig=$1
b_by_b=$2
main_dir=$3



final_wig="${main_dir}/${wig}_${b_by_b}"

wig="${main_dir}/${wig}_final"
b_by_b="${main_dir}/${b_by_b}_final"

mkdir -p $final_wig

for dir in $(ls $b_by_b)
do
	mkdir -p $final_wig/$dir
	
	for file in $(ls $b_by_b/$dir)
	do
        paste $wig/$dir/$file $b_by_b/$dir/$file > $final_wig/$dir/$file
    done
done

