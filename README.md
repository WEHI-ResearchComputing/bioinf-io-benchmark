# bioinf IO benchmarks

## Preparation
1. Download a human reference genome [http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz)
2. Download this tool generate test data: [https://www.niehs.nih.gov/research/resources/software/biostatistics/art/](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/)
3. Generate synthetic data
```
/path/to/art_illumina -ss HS25 -i /path/to/hg38.fa -o ./fake_data -l 150 -f 30 -p -m 500 -s 10 -sam
```
