#!/bin/bash

#PBS -N PopGenome_human_Chr17
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=8:00:00

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/Promoter_PopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_batch_chr17.R

echo "Job complete"

exit
