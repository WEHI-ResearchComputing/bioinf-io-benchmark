#!/bin/bash

# 1. Configure resources
#SBATCH --job-name="IO benchmark" 
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=20
#SBATCH --mem=32G
#SBATCH --output=bm-%j.out

# 2. If not running in the batch system, submit to the batch system
if [[ -z $SLURM_JOBID ]]; then
    n=1
    while getopts 'n:' c
    do
	case $c in
	    n) n=$OPTARG ;;
	esac
    done
    for i in `seq 1 $n`
    do
	sbatch $0
    done
    exit 0
fi

echo running on `hostname`
date

# 2. Set the working dir
if [[ -z $PBS_O_WORKDIR ]]; then
	WORK_DIR=`pwd`/..
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

# 6. Output directory
unset TMPDIR
OUTPUT_DIR=$(mktemp -d -t output-XXXXXX -p $WORK_DIR)
echo Writing to $OUTPUT_DIR

# Trim
echo trim started
time java -jar ${TRIMMOMATIC}/trimmomatic-0.36.jar PE -threads `nproc` $READ1 $READ2 -baseout ${OUTPUT_DIR}/output-trimmed.fastq.gz ILLUMINACLIP:${TRIMMOMATIC}/adapters/TruSeq3-PE.fa:1:30:20:4:true
echo trim ended

# Align
echo align started
time bwa mem -M -t `nproc` $REFERENCE ${OUTPUT_DIR}/output-trimmed_1P.fastq.gz ${OUTPUT_DIR}/output-trimmed_2P.fastq.gz > ${OUTPUT_DIR}/aln.sam
echo align ended

# Sort
echo sort started
time samtools sort -@ `nproc` ${OUTPUT_DIR}/aln.sam > ${OUTPUT_DIR}/aln.bam
echo sort ended

# index
echo index started
time samtools index ${OUTPUT_DIR}/aln.bam
echo index ended

