#!/bin/bash

echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed\tindex\tn_genomes\tRef_inno\tAlt_noninno\t" > december/fixed_inno.bed 
echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed\tindex\tn_genomes\tRef_inno\tAlt_noninno\t" > december/fixed_noninno.bed 
echo -e "chrom\tstart\tstop\ttype\tinno\tnon_inno\tfixed\tindex\tn_genomes\tRef_inno\tAlt_noninno\t" > december/two_alleles.bed 

sbatch scripts_october/job_arr_ex2.sh 9161303 fixed_inno_all.bed
sbatch scripts_october/job_arr_ex2.sh 8749346 fixed_noninno_all.bed
sbatch scripts_october/job_arr_ex2.sh 1562 two_alleles_all.bed