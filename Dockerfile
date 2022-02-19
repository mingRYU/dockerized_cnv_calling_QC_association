# FROM romanhaa/penncnv
# FROM umichbfxcore/ipattern:manual
FROM python:2

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install vim curl r-base build-essential libperl-dev

COPY ./DOCKER_CONTAINER_WORKDIR /WORKDIR

# Clone pipeline code
RUN cd /WORKDIR && git clone https://github.com/QidiFeng/cnv_calling_QC_association.git
# Unzip iPattern 
RUN cd /WORKDIR && tar -xvzf /WORKDIR/cnv_calling_QC_association/softwares/ipn_0.582.tar.gz 
# Install required packages in Python and R
RUN pip2 install numpy
RUN Rscript /WORKDIR/install_R_package.r
# Install PennCNV
RUN wget https://github.com/WGLab/PennCNV/archive/refs/tags/v1.0.5.zip
RUN unzip v1.0.5.zip
RUN rm v1.0.5.zip
RUN mv PennCNV-1.0.5 /WORKDIR/PennCNV
RUN cd /WORKDIR/PennCNV/kext && make
# Install plink
RUN wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20210606.zip
RUN unzip plink_linux_x86_64_20210606.zip
RUN rm plink_linux_x86_64_20210606.zip
RUN mv plink /bin

CMD ["/bin/bash"]
