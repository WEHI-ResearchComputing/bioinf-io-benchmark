# bioinf IO benchmarks

This benchmark performs the basic actions that start most bioinformatics WGS  pipelines.

## Sample scripts
There are sample scripts for Pawsey, Spartan and Milton in the directories of those names. These are starter scripts that you will need to modify, details such as paths and accounts will probably not match your environment.

## Preparation
1. Download a human reference genome [http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz)
2. Create and index for the reference: `bwa index -a bwtsw /path/to/hg38.fa`
3. Download this tool to generate test data: [https://www.niehs.nih.gov/research/resources/software/biostatistics/art/](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/)
4. Generate synthetic data
```
/path/to/art_illumina -ss HSXt -i /path/to/hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -na
```
5. These will take a while, submit to the batch system and have a cup of tea (or take a holiday if you're running on spartan). There are starter scripts in `<site>/create-reads.sh` and `<site>/index.sh`


## Run the benchmark
edit `<site>/run.sh`:
*  check that all the required tools are on your path. These are available in the pasth
    1. trimmomatic, which in turn depends on java
    2. bwa
    3. samtools
* check that script points:
    1.  to the human reference genome
    2.  the synthetic reads
* Decide what resources to give the tools
* Run in your queueing system or interactively.


## Results
These are the elaspsed time, in seconds, results of a _single_ run.

| Tool           | Milton | Pawsey (zeus) | Spartan |
|----------------|-------:|--------------:|--------:|
| trimmomatic    | 14,854 |        16,049 |  19,187 |
| bwa mem        | 14,726 |        11,903 |  13,611 |
| samtools sort  |  5,015 |         2,730 |   2,545 |
| samtools index |    807 |           707 |     946 |

Comments:
1. trimmomatic is dominated by single threaded sequential reading and writing.
2. bwa mem is dominated by CPU and scales well with more CPUs
3. samtools sort is dominated by multithreaded sequential reading and writing.
4. samtools index is (I think) is dominated by single threaded reading.



