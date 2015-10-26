FROM debian:stable
MAINTAINER Nathan Olson "https://github.com/nate-d-olson"
# edited by Adrian Fritz Adrian.Fritz@Helmholtz-HZI.de

# Setup a base system 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y -q   \ 
                            git \
                            build-essential \
                           # automake \
                           # curl \
                            wget \
                            unzip \
                            # samtools dependency
                            zlib1g-dev \
                            libbz2-dev \
                            # samtools dependency
                            libncurses5-dev \
                            # cmake dependency - installed with reapr
                            libarchive-dev \ 
                            # cmake dependency - installed with reapr
                            libexpat1-dev \
                          #  libyaml-dev \
                            openjdk-7-jdk \
                            openjdk-7-jre \
                            r-base \
                            r-base-dev \
                            r-recommended \
                            python-setuptools \
                            python-pip

RUN echo 'options(repos = list(CRAN = "http://cran.rstudio.com/"))' >> /etc/R/Rprofile.site

# install bowtie2 
RUN wget http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.2/bowtie2-2.2.2-linux-x86_64.zip;\
    unzip bowtie2-2.2.2-linux-x86_64.zip && rm -rf bowtie2-2.2.2-linux-x86_64.zip;\
    ln -s `pwd`/bowtie*/bowtie* /usr/local/bin

# install htslib samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2;\
    tar -xaf samtools-1.2.tar.bz2 && rm -rf samtools-1.2.tar.bz2 ;\
    cd samtools-1.2;\
    make && ln -f -s `pwd`/* /usr/local/bin/ && cd ../

# install bedtools
RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.24.0/bedtools-2.24.0.tar.gz;\
    tar -xaf bedtools-2.24.0.tar.gz && rm -rf bedtools-2.24.0.tar.gz ;\
    cd bedtools2;\
    make && ln -f -s `pwd`/bin/* /usr/local/bin/ && cd ../ 

# install Perl modules for REAPR
RUN apt-get install -y cpanminus
RUN cpanm -v JSON File::Basename File::Copy File::Spec File::Spec::Link Getopt::Long List::Util

# instal REAPR
RUN wget ftp://ftp.sanger.ac.uk/pub/resources/software/reapr/Reapr_1.0.18.tar.gz;\
    tar -xaf Reapr_1.0.18.tar.gz && rm -rf Reapr_1.0.18.tar.gz;\
    cd Reapr_1.0.18;\
    ./install.sh && ln -f -s `pwd`/reapr /usr/local/bin/ && cd ../

# install VALET
RUN apt-get install -y -q python-numpy python-scipy
RUN git clone https://github.com/cmhill/VALET.git
RUN ln -s VALET/src/py/valet.py valet
RUN chmod +x valet

VOLUME ["/output"]

# ENTRYPOINT python /VALET/src/py/valet.py
# CMD ['-a', '-p', '-1', '-2','--assembly-names']

