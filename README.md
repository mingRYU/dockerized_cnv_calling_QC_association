# dockerized_cnv_calling_QC_association
Dockerized software from: https://github.com/QidiFeng/cnv_calling_QC_association

Create container with /data mounted: 
    docker run -d --mount type=bind,source="$(pwd)"/DOCKER_CONTAINER_WORKDIR,target=/WORKDIR cnv_pipeline bash /WORKDIR/run_part1.sh
