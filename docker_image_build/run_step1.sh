#!/bin/bash
source /WORKDIR/config.sh

# Part 1
cd /software/cnv_calling_QC_association/code
perl 01_01_signalDensity_samplelist.pl  ${COHORT_NAME}   /WORKDIR/data/${REPORT_FILE_NAME}    /WORKDIR/data/${PHENOTYPE_FILE_NAME}  /WORKDIR/   /WORKDIR/

cd /WORKDIR/penn/${COHORT_NAME}/data_aux/
perl /software/PennCNV/compile_pfb.pl -listfile samplelist -snpposfile snplist.txt -output pfbfile

perl /software/PennCNV/cal_gc_snp.pl /software/cnv_calling_QC_association/supp_files/gc5Base.txt snplist.txt -output gcmodel
