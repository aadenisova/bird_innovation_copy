#!/bin/bash


for file in $(ls best_genes/)
do
echo $file >> maf_for_best_positions.txt
    tail -n+2 best_genes/$file | while read chrom start GENE_NAME; do
        echo $GENE_NAME >> maf_for_best_positions.txt

        start="$(($start-1))"

        mafExtractor --maf maf_by_chrom/maf_8sp/${chrom}.maf --seq GCF_003957565.2_bTaeGut1.4.pri.$chrom \
        --start $start --stop $start >> maf_for_best_positions.txt
    done


    #mafExtractor --maf maf_by_chrom/maf_8sp/NC_044211.2.maf --seq GCF_003957565.2_bTaeGut1.4.pri.NC_044211.2 \
#--start 19261802 --stop 19261802 

done
