#!/bin/bash

#PBS -l nodes=1:ppn=2,mem=8gb,walltime=24:00:00
#PBS -N create reads 
##SBATCH --job-name="create reads" 
##SBATCH ­-time=24:00:00
##SBATCH ­-ntasks=1
##SBATCH --mem=8G


cd ~/bioinf-io-benchmark
~/bioinf-io-benchmark/art_src_MountRainier_Linux/art_illumina -ss HSXt -i hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -na
