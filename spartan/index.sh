#!/bin/bash

#SBATCH -A punim0930
#SBATCH --job-name="bwa index" 
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --mem=16G
#SBATCH --partition=physical

WORK_DIR=/scratch/punim0930/evan/bioinf-io-benchmark
cd $WORK_DIR

echo -
pwd -P
ls
echo -

module load BWA/0.7.17-intel-2018.u4
bwa index -a bwtsw hg38.fa
