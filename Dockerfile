FROM romanhaa/penncnv
FROM umichbfxcore/ipattern:manual

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq install vim r-base curl

COPY ./DOCKER_CONTAINER_WORKDIR /WORKDIR
# COPY ./WORKDIR_data /WORKDIR

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output /WORKDIR/get-pip.py
RUN python2 /WORKDIR/get-pip.py
RUN pip install -r /WORKDIR/requirements.txt
RUN mv /bin/python2.7 /bin/python

CMD ["/bin/bash"]