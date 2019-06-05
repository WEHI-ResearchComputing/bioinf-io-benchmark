# bioinf IO benchmarks

This benchmark performs the basic actions that start most bioinformatics WGS  pipelines.

## Preparation
1. Download a human reference genome [http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz)
2. Create and index for the reference: `bwa index -a bwtsw /path/to/hg38.fa`
3. Download this tool to generate test data: [https://www.niehs.nih.gov/research/resources/software/biostatistics/art/](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/)
4. Generate synthetic data
```
/path/to/art_illumina -ss HSXt -i /path/to/hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -na
```
These will take a while, have a cup of tea.

## Run the benchmark
edit run.sh:
*  check that all the required tools are on your path. These are available in the pasth
    1. trimmomatic, which in turn depends on java
    2. bwa
    3. samtools
* check that script points:
    1.  to the human reference genome
    2.  the synthetic reads
* Decide what resources to give the tools
* Run in your queueing system or interactively.


