#!/bin/bash

#PBS -N PopGenome_human_Chr8
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=96gb
#PBS -l walltime=18:00:00

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/Promoter_PopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_batch_chr8.R

echo "Job complete"

exit
