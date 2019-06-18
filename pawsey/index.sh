#!/bin/bash -l

#SBATCH -A director2131
#SBATCH --job-name="bwa index" 
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --mem=8G
#SBATCH --export=NONE
#SBATCH --partition=workq

#module load BWA/0.7.17-intel-2018.u4
module load bwa
cd /scratch/director2131/ethomas/bioinf-io-benchmark
bwa index -a bwtsw hg38.fa
