#!/bin/bash

#PBS -N PopGenome_human_test
#PBS -k o
#PBS -q debug
#PBS -l nodes=1:ppn=16,vmem=72gb
#PBS -l walltime=6:00:00
#BS -m abe

module load r

WD=/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/scripts

cd $WD

echo "Starting job"

R CMD BATCH PopGenome_batch.R

exit
