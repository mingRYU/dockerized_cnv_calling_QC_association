# dockerized_cnv_calling_QC_association
Dockerized software from: https://github.com/QidiFeng/cnv_calling_QC_association

Create container with /data mounted: 
    docker run -it --mount type=bind,source="$(pwd)"/data,target=/data,readonly cnv_pipeline
