#!/bin/bash

wig=$1
main_dir=$2
final_wig="${main_dir}/${wig}_final"

wig="${main_dir}/${wig}"

mkdir -p $final_wig

for dir in $(ls $wig)
do
	mkdir -p $final_wig/$dir
	
	for file in $(ls $wig/$dir)
	do
        final_result="${file}_final"
        tail -n+2  $wig/$dir/$file | grep -v 'fixedStep' > $final_wig/$dir/$final_result
    done
done



