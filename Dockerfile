FROM python:2

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install vim curl r-base build-essential libperl-dev

COPY ./DOCKER_CONTAINER_WORKDIR/install_R_package.r /WORKDIR/install_R_package.r
COPY ./DOCKER_CONTAINER_WORKDIR/ppc_1.01.tar.gz /WORKDIR/ppc_1.01.tar.gz
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

# Install required packages in Python and R
RUN pip2 install numpy
RUN Rscript /WORKDIR/install_R_package.r

# Install plink
RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20210606.zip
RUN unzip plink_linux_x86_64_20210606.zip
RUN rm plink_linux_x86_64_20210606.zip
RUN mv plink /bin

CMD ["/bin/bash"]
