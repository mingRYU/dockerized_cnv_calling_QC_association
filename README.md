# dockerized_cnv_calling_QC_association
Dockerized pipeline from: https://github.com/QidiFeng/cnv_calling_QC_association

Create container with /DOCKER_CONTAINER_WORKDIR directory mounted: 
    `docker run -d --mount type=bind,source="$(pwd)"/DOCKER_CONTAINER_WORKDIR,target=/WORKDIR cnv_pipeline bash /WORKDIR/run_part[1 or 2 or 3].sh`
