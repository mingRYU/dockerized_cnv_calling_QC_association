FROM python:2

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install vim curl r-base build-essential libperl-dev

COPY ./install_R_package.r /build/install_R_package.r
COPY ./ppc_1.01.tar.gz /build/ppc_1.01.tar.gz
COPY ./run_step1.sh /scripts/run_step1.sh
COPY ./run_step2.sh /scripts/run_step2.sh
COPY ./run_step3.sh /scripts/run_step3.sh

# Install required packages in Python and R
RUN pip2 install numpy
RUN Rscript /build/install_R_package.r
RUN rm -rf /build

RUN mkdir /software
# Clone CNV pipeline code
RUN cd /software && git clone https://github.com/QidiFeng/cnv_calling_QC_association.git
# Unzip iPattern 
RUN cd /software && tar -xvzf cnv_calling_QC_association/softwares/ipn_0.582.tar.gz 
# Install PennCNV
RUN wget https://github.com/WGLab/PennCNV/archive/refs/tags/v1.0.5.zip
RUN unzip v1.0.5.zip
RUN rm v1.0.5.zip
RUN mv PennCNV-1.0.5 /software/PennCNV
RUN cd /software/PennCNV/kext && make

# Install plink
RUN wget https://zzz.bwh.harvard.edu/plink/dist/plink-1.07-x86_64.zip
RUN unzip plink-1.07-x86_64.zip
RUN rm plink-1.07-x86_64.zip
RUN mv /plink-1.07-x86_64/plink /bin

CMD ["/bin/bash"]
