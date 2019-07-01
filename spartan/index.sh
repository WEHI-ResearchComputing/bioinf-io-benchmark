#!/bin/bash

#SBATCH -A punim0001
#SBATCH --job-name="bwa index" 
#SBATCH --time=02:00:00
#SBATCH ­-ntasks=1
#SBATCH --mem=8G

WORK_DIR=/scratch/punim0930/evan/bioinf-io-benchmark
cs $WORKDIR

module load BWA/0.7.17-intel-2018.u4
cd ~/bioinf-io-benchmark
bwa index -a bwtsw hg38.fa
