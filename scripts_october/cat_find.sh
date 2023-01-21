#!/bin/bash

cat december/intervals_by_chrom2/fixed_inno* > december/intervals_cated/fixed_inno_all.bed
cat december/intervals_by_chrom2/fixed_noninno* > december/intervals_cated/fixed_noninno_all.bed
cat december/intervals_by_chrom2/two_alleles* > december/intervals_cated/two_alleles_all.bed