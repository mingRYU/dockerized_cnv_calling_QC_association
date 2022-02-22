#!/bin/bash
source config.sh
# Part 2
# run iPattern
cd /WORKDIR/ipn_0.582/preprocess/ilmn/
export IPNBASE=/WORKDIR/ipn_0.582
export PYTHONPATH=$PYTHONPATH:/WORKDIR/ipn_0.582/ipnlib
bash ilmn.sh /WORKDIR/ipn/${COHORT_NAME}/data_aux/conf.sublistaa.txt

## In case when run_ipattern.py of some chr.p or chr.q failed due to not having enough probes after filtering, run following 
## line to concatenate all .report files under directory ${COHORT_NAME}.sublist*_call:

cat /WORKDIR/ipn_0.582/preprocess/ilmn/${COHORT_NAME}.sublistaa_call/*report > /WORKDIR/ipn/${COHORT_NAME}/out/${COHORT_NAME}.sublistaa_all_calls.txt

# run PennCNV
perl /WORKDIR/PennCNV/detect_cnv.pl \
    -test \
    -hmm /WORKDIR/PennCNV/lib/hhall.hmm \
    -pfb /WORKDIR/penn/${COHORT_NAME}/data_aux/pfbfile \
    -gcmodel /WORKDIR/penn/${COHORT_NAME}/data_aux/gcmodel \
    -listfile /WORKDIR/penn/${COHORT_NAME}/data_aux/samplelist \
    -confidence \
    -log /WORKDIR/penn/${COHORT_NAME}/out/sample.log \
    -out /WORKDIR/penn/${COHORT_NAME}/out/sample.rawcnv