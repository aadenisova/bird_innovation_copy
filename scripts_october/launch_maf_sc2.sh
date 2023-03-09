#!/bin/bash

list_inno=$1
list_noninno=$2
num=$3

for i in {1..199}
do
    value=$(ls maf_by_chrom_big/ | sed "${i}q;d")
    python scripts_october/maf_screening.py maf_by_chrom_big/$value $list_inno $list_noninno $num
done


# python scripts_october/maf_screening.py maf_by_chrom_big/NC_044239.2.maf \
# 2_bTaeGut1,1_bAlcTor1,1_bSylBor1,1_bBucAby1 1_bGeoTri1,1_bSteHir1,1_bSylAtr1,4_bAquChr1 1