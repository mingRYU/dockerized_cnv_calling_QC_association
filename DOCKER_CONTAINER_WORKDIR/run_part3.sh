#!/bin/bash
source /WORKDIR/config.sh

# Part 3
cd /software/cnv_calling_QC_association/code/
ipn_dir=/WORKDIR
penn_dir=/WORKDIR
out_dir=/WORKDIR/output
cohort_list=/WORKDIR/data/${COHORT_LIST_FILE_NAME}
chromosome_length=/software/cnv_calling_QC_association/supp_files/hg19_chromosome_length.txt
phenofile=/WORKDIR/data/${PHENOTYPE_FILE_NAME}
exon_gene_list=/software/cnv_calling_QC_association/supp_files/ensemble_exon_genelist.txt
centromere_telomere=/software/cnv_calling_QC_association/supp_files/hg19_telomere_centrometric.txt

bash 02_0_CNVcombine_QC.sh $ipn_dir $penn_dir $out_dir $cohort_list $chromosome_length $phenofile $exon_gene_list $centromere_telomere