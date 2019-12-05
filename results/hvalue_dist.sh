#!/bin/bash 
  #PBS -k o 
  #PBS -l nodes=1:ppn=6,walltime=1:00:00,vmem=64gb
  #PBS -N hvalue_dist_test
  #PBS -j oe 
  #PBS -q debug

cd /N/dc2/projects/PromoterPopGen/hval_dist_analysis/PopGen_matrix_test

R CMD BATCH hvalue_dist.R
