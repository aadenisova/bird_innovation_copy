#!/bin/bash

sbatch -p vgl scripts_october/make_final_wig.sh wig december
sbatch -p vgl scripts_october/make_final_bbyb.sh b_by_b december
