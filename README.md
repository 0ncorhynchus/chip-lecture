## What Is?

Ubuntu(14.04trusty) container including some bioinformatics tools.

contains:
* SRA Toolkit 2.5.0
* Bowtie 1.1.1
* FastQC 0.11.3
* Samtools 1.2
* MACS2

## Build

```bash
$ sudo docker build -t chip-lecture .
```

## Usage

In your work directory

```{bash}
$ sudo docker run --rm -i -t -v `pwd`:/data chip-lecture
```
