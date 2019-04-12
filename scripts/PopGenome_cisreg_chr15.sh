#!/bin/bash

#PBS -N PopGenome_human_Chr15
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=4:00:00

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/Promoter_PopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_cisreg_chr15.R

echo "Job complete"

exit
