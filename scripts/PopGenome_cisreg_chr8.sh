#!/bin/bash

#PBS -N PopGenome_human_Chr8
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=4:00:00

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_cisreg_chr8.R

echo "Job complete"

exit
