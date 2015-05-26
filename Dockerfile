FROM ubuntu:14.04

MAINTAINER Suguru Kato <salmon.bioinformtics@gmail.com>

RUN apt-get update

RUN apt-get install -y unzip curl

# Installing Python, Cython and Numpy
RUN apt-get install -y build-essential python python-dev
RUN curl -kL https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
RUN pip install cython numpy

# Installing MACS2
RUN pip install MACS2

# Installing the SRA Toolkit 2.5.0
ADD http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.5.0-1/sratoolkit.2.5.0-1-ubuntu64.tar.gz /tmp/
RUN cd /tmp; tar -xzf sratoolkit.2.5.0-1-ubuntu64.tar.gz
RUN mv /tmp/sratoolkit.2.5.0-1-ubuntu64 /opt/sratoolkit
ENV PATH /opt/sratoolkit/bin:$PATH

# Installing the Bowtie 1.1.1
# Please download from Sourceforge
COPY bowtie-1.1.1-linux-x86_64.zip /tmp/
RUN cd /tmp; unzip bowtie-1.1.1-linux-x86_64.zip
RUN mv /tmp/bowtie-1.1.1 /opt/bowtie
ENV PATH /opt/bowtie:$PATH

# Installing the FastQC 0.11.3
RUN apt-get install -y openjdk-7-jre
ADD http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3.zip /tmp/
RUN cd /tmp; unzip fastqc_v0.11.3.zip
RUN mv /tmp/FastQC /opt/FastQC
RUN chmod 755 /opt/FastQC/fastqc; ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc

# Installing the Samtools 1.2
# Please download from Sourceforge
RUN apt-get install -y zlib1g-dev libncurses5-dev
COPY samtools-1.2.tar.bz2 /tmp/
RUN cd /tmp; tar -jxf samtools-1.2.tar.bz2
RUN cd /tmp/samtools-1.2; make; make prefix=/opt/samtools install
ENV PATH /opt/samtools/bin:$PATH


# Add a user
RUN useradd -d /data -m chip-user
USER chip-user
WORKDIR /data

# Setting a mount point
VOLUME /data

CMD ["/bin/bash"]
