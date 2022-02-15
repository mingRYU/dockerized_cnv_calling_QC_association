mkdir DOCKER_CONTAINER_WORKDIR
cd ./DOCKER_CONTAINER_WORKDIR
mkdir data
git clone https://github.com/WGLab/PennCNV.git
git clone https://github.com/QidiFeng/cnv_calling_QC_association.git
tar -xzf ./DOCKER_CONTAINER_WORKDIR/cnv_calling_QC_association/softwares/ipn_0.582.tar.gz
# git clone https://github.com/zaxf/iPattern.git

