#!/bin/bash

#SBATCH --job-name="create reads" 
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --output=create-reads-%j.out

module load bwa
cd ..

if [ ! -f hg38.fa.bwt ]; then
    bwa index -a bwtsw hg38.fa
fi

./art_src_MountRainier_Linux/art_illumina -ss HSXt -i hg38.fa -o fake_data -l 150 -f 30 -p -m 500 -s 10 -na
