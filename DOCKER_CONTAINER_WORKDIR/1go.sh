COHORT_NAME=Ma_xajd
# Part 1
cd /WORKDIR/cnv_calling_QC_association/code
perl 01_01_signalDensity_samplelist.pl  ${COHORT_NAME}   ../example/finalreport.txt    ../example/MA.phe  /WORKDIR/   /WORKDIR/

cd /WORKDIR/penn/${COHORT_NAME}/data_aux/
perl /WORKDIR/PennCNV/compile_pfb.pl -listfile samplelist -snpposfile snplist.txt -output pfbfile

perl /WORKDIR/PennCNV/cal_gc_snp.pl /WORKDIR/cnv_calling_QC_association/supp_files/gc5Base.txt snplist.txt -output gcmodel

# Part 2
cd /WORKDIR/ipn_0.582/preprocess/ilmn/
export IPNBASE=/WORKDIR/ipn_0.582
export PYTHONPATH=$PYTHONPATH:/WORKDIR/ipn_0.582/ipnlib
bash ilmn.sh /WORKDIR/ipn/Ma_xajd/data_aux/conf.sublistaa.txt