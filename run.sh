#!/bin/bash

# 1. Configure resources

#PBS -l nodes=1:ppn=20,mem=32gb,walltime=24:00:00

# 2. Set the working dir
WORK_DIR=$PBS_O_WORKDIR

# 3. Makesure software is in your path
module load baw samtools
TRIMMOMATIC=/stornext/System/data/apps/trimmomatic/trimmomatic-0.36

# 4. The reference genome
REFERENCE=$WORK_DIR/hg38.fa

# 5. Sequence data
READ1=$WORK_DIR/fake_data1.fq
READ2=$WORK_DIR/fake_data2.fq

# Trim
java -jar ${TRIMMOMATIC}/trimmomatic-0.36.jar PE -threads `nproc` $READ1 $READ2 -baseout ${WORK_DIR}/output-trimmed.fastq.gz ILLUMINACLIP:${TRIMMOMATIC}/adapters/TruSeq3-PE.fa:1:30:20:4:true

# Align
bwa mem -M -t `nproc` $REFERENCE ${WORK_DIR}/output-trimmed.fastq_1P.gz ${WORK_DIR}/output-trimmed.fastq_2P.gz read2.fq > ${WORK_DIR}/aln.sam

# Sort
samtools sort ${WORK_DIR}/aln.sam > ${WORK_DIR}/aln.bam

# index
samtools index > ${WORK_DIR}/aln.bam
