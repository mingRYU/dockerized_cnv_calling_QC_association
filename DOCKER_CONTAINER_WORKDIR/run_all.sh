COHORT_NAME=Ma_xajd

# Part 1
cd /WORKDIR/cnv_calling_QC_association/code
perl 01_01_signalDensity_samplelist.pl  ${COHORT_NAME}   /WORKDIR/data/finalreport.txt    /WORKDIR/data/MA.phe  /WORKDIR/   /WORKDIR/

cd /WORKDIR/penn/${COHORT_NAME}/data_aux/
perl /WORKDIR/PennCNV/compile_pfb.pl -listfile samplelist -snpposfile snplist.txt -output pfbfile

perl /WORKDIR/PennCNV/cal_gc_snp.pl /WORKDIR/cnv_calling_QC_association/supp_files/gc5Base.txt snplist.txt -output gcmodel

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


# Part 3
cd /WORKDIR/cnv_calling_QC_association/code/
ipn_dir=/WORKDIR
penn_dir=/WORKDIR
out_dir=/WORKDIR/output
cohort_list=/WORKDIR/data/cohort.list
chromosome_length=/WORKDIR/cnv_calling_QC_association/supp_files/hg19_chromosome_length.txt
phenofile=/WORKDIR/data/MA.phe
exon_gene_list=/WORKDIR/cnv_calling_QC_association/supp_files/ensemble_exon_genelist.txt
centromere_telomere=/WORKDIR/cnv_calling_QC_association/supp_files/hg19_telomere_centrometric.txt

bash 02_0_CNVcombine_QC.sh $ipn_dir $penn_dir $out_dir $cohort_list $chromosome_length $phenofile $exon_gene_list $centromere_telomere