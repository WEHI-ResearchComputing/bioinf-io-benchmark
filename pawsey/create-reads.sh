#!/bin/bash

#SBATCH -A director2131
#SBATCH --job-name="create reads" 
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --mem=8G
#SBATCH --export=NONE
#SBATCH --partition=workq


#module load GSL/1.16-spartan_intel-2017.u2
cd /scratch/director2131/ethomas/bioinf-io-benchmark

export LD_LIBRARY_PATH=`pwd -P`

./art_src_MountRainier_Linux/art_illumina -ss HSXt -i hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -na
