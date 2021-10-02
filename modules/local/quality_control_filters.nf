process QUALITY_CONTROL_FILTERS {

  //publishDir "$params.output/01_quality_control", mode: 'copy'

  input:
    tuple val(genotyped_plink_filename), path(genotyped_plink_bim_file), path(genotyped_plink_bed_file), path(genotyped_plink_fam_file)

  output:
    path "${genotyped_plink_filename}.qc.*", emit: genotyped_qc

  """
  plink2 \
    --bfile ${genotyped_plink_filename} \
    --maf ${params.qc_maf} \
    --mac ${params.qc_mac} \
    --geno ${params.qc_geno} \
    --hwe ${params.qc_hwe} \
    --mind ${params.qc_mind} \
    --write-snplist --write-samples --no-id-header \
    --out ${genotyped_plink_filename}.qc
  """

}
