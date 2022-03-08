#!/bin/bash
source /WORKDIR/config.sh

# run iPattern
cd /software/ipn_0.582/preprocess/ilmn/
export IPNBASE=/software/ipn_0.582
export PYTHONPATH=$PYTHONPATH:/software/ipn_0.582/ipnlib
bash ilmn.sh /WORKDIR/ipn/${COHORT_NAME}/data_aux/conf.sublist${subset_code}.txt

if [ ! -f /WORKDIR/ipn/${COHORT_NAME}/out/${COHORT_NAME}.sublist${subset_code}_all_calls.txt ]
then
    ## run_ipattern.py of some chr.p or chr.q may failed due to not having enough probes after filtering, so we run following 
    ## line to concatenate all .report files under directory ${COHORT_NAME}.sublist*_call:
    cat /software/ipn_0.582/preprocess/ilmn/${COHORT_NAME}.sublist${subset_code}_call/*report > /WORKDIR/ipn/${COHORT_NAME}/out/${COHORT_NAME}.sublist${subset_code}_all_calls.txt
fi
