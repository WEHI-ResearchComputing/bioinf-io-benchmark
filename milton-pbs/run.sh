#!/bin/bash

# 1. Configure resources
#PBS -l nodes=1:ppn=20,mem=32gb,walltime=24:00:00

# 2. Set the working dir
if [[ -z $PBS_O_WORKDIR ]]; then
	WORK_DIR=`pwd`
else
	WORK_DIR=$PBS_O_WORKDIR
fi

# 3. Makesure software is in your path
module load bwa samtools
TRIMMOMATIC=/stornext/System/data/apps/trimmomatic/trimmomatic-0.36

# 4. The reference genome
REFERENCE=$WORK_DIR/hg38.fa

# 5. Sequence data
READ1=$WORK_DIR/fake_data1.fq
READ2=$WORK_DIR/fake_data2.fq

# Trim
echo trim started
time java -jar ${TRIMMOMATIC}/trimmomatic-0.36.jar PE -threads `nproc` $READ1 $READ2 -baseout ${WORK_DIR}/output-trimmed.fastq.gz ILLUMINACLIP:${TRIMMOMATIC}/adapters/TruSeq3-PE.fa:1:30:20:4:true
echo trim ended

# Align
echo align started
time bwa mem -M -t `nproc` $REFERENCE ${WORK_DIR}/output-trimmed_1P.fastq.gz ${WORK_DIR}/output-trimmed_2P.fastq.gz > ${WORK_DIR}/aln.sam
echo align ended

# Sort
echo sort started
time samtools sort -@ `nproc` ${WORK_DIR}/aln.sam > ${WORK_DIR}/aln.bam
echo sort ended

# index
echo index started
time samtools index ${WORK_DIR}/aln.bam
echo index ended

