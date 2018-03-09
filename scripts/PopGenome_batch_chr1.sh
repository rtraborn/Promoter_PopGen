#!/bin/bash

#PBS -N PopGenome_human_Chr1
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=16:00:00
#PBS -m abe

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_batch_chr1.R

echo "Job complete"

exit
