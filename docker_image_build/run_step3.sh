#!/bin/bash
source /WORKDIR/config.sh

# Run PennCNV
perl /software/PennCNV/detect_cnv.pl \
    -test \
    -hmm /software/PennCNV/lib/hhall.hmm \
    -pfb /WORKDIR/penn/${COHORT_NAME}/data_aux/pfbfile \
    -gcmodel /WORKDIR/penn/${COHORT_NAME}/data_aux/gcmodel \
    -listfile /WORKDIR/penn/${COHORT_NAME}/data_aux/samplelist \
    -confidence \
    -log /WORKDIR/penn/${COHORT_NAME}/out/sample.log \
    -out /WORKDIR/penn/${COHORT_NAME}/out/sample.rawcnv

# Intersection of Raw CNV (PennCNV and iPattern) and QC
cd /software/cnv_calling_QC_association/code/
ipn_dir=/WORKDIR
penn_dir=/WORKDIR
out_dir=/WORKDIR/output
cohort_list=/WORKDIR/data/${COHORT_LIST_FILE_NAME}
chromosome_length=/software/cnv_calling_QC_association/supp_files/hg19_chromosome_length.txt
phenofile=/WORKDIR/data/${PHENOTYPE_FILE_NAME}
gene_file=/software/cnv_calling_QC_association/supp_files/ensemble_exon_genelist.txt
centromere_telomere=/software/cnv_calling_QC_association/supp_files/hg19_telomere_centrometric.txt

bash 02_0_CNVcombine_QC.sh $ipn_dir $penn_dir $out_dir $cohort_list $chromosome_length $phenofile $exon_gene_list $centromere_telomere


# CNVburden calculation
Rscript 03_1_cnvburden.r /WORKDIR $out_dir/02_11_plinked $gene_file $phenofile