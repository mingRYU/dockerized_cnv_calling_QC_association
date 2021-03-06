# dockerized_cnv_calling_QC_association
Dockerized pipeline from: https://github.com/QidiFeng/cnv_calling_QC_association

## Notes for building docker image from Dockerfile and running the pipeline

1. Make sure your machine has Docker Engine installed(follow this link to install: https://docs.docker.com/engine/install/).
2. Run this to clone this repo and cd into it: <br/> `git clone https://github.com/mingRYU/dockerized_cnv_calling_QC_association && cd dockerized_cnv_calling_QC_association`
3. Pull image from docker hub: <br/> `docker pull mingrayyu/cnv_calling:latest` <br/>
    The Dockerfile and other files needed to build the image are in `./docker_image_build`. Alternative, to build docker image from Dockerfile: <br/> `docker build -t cnv_calling docker_image_build/`
4. Move all the input files into `DOCKER_CONTAINER_WORKDIR/data` directory and modify the variables in `config.sh` so that these variables correspond to the file names for your input files <br/>(NOTE that the pipeline scripts assumes all input files are under the `DOCKER_CONTAINER_WORKDIR/data` directory).
5. Run pipeline scripts inside a Docker container with `./DOCKER_CONTAINER_WORKDIR` directory mounted: <br/> 
    STEP1: <br/>`docker run -d --mount type=bind,source="$(pwd)"/DOCKER_CONTAINER_WORKDIR,target=/WORKDIR mingrayyu/cnv_calling bash /scripts/run_step1.sh`<br/>
    
    Check below **Notes for running run_step2.sh** before running step2 <br/>
    STEP2: <br/>`docker run -d --mount type=bind,source="$(pwd)"/DOCKER_CONTAINER_WORKDIR,target=/WORKDIR mingrayyu/cnv_calling bash /scripts/run_step2.sh`<br/>
    
    STEP3: <br/>`docker run -d --mount type=bind,source="$(pwd)"/DOCKER_CONTAINER_WORKDIR,target=/WORKDIR mingrayyu/cnv_calling bash /scripts/run_step3.sh`<br/>

### Notes for running `run_step2.sh`:
Before running `run_step2.sh`, you must set `$subset_code` in `config.sh` to `aa`, `ab`, `ac`, etc, where `aa` represents 1, `ab` represents 2, `ac` represents 3 , and so on.<br/> 

`aa`, `ab`, `ac`, etc represents different subsets of your cohort(because iPattern requires each batch to have >=100 and <=300 samples, your cohort will be splitted into different subsets, which is what `run_step1.sh` does). You can find the subset lists(named as sublistaa, sublistab, etc) which have been generated after finished running `run_step1.sh` under `DOCKER_CONTAINER_WORKDIR/ipn/${COHORT_NAME}/data_aux/`<br/>

In other words, after running `run_step1.sh`, let's say there were 3 subsets generated for your cohort -- `aa`, `ab`, `ac` -- then you need to execute `run_part2.sh` 3 times, each time with a different $subset_code(i.e `aa`, `ab`, `ac`). They can be ran in parallel, but make sure that they are all finished before moving on to `run_step3.sh`.
