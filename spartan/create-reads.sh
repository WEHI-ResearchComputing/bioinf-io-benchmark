#!/bin/bash

#SBATCH -A punim0001
#SBATCH --job-name="create reads" 
#SBATCH --time=4-00:00:00
#SBATCH --ntasks=1
#SBATCH --mem=8G

module load GSL/1.16-spartan_intel-2017.u2
cd /data/cephfs/punim0001/evan/bioinf-io-benchmark

./art_src_MountRainier_Linux/art_illumina -ss HSXt -i hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -na
