library(PopGenome)

#Importing data
GENOME.class <- readVCF("ALL.chr22.1kGP.vcf.gz", numcols=100000, tid="22", from=1, to=1000)

#Retrieving names 
vcf_handle <- .Call("VCF_open", "ALL.chr22.1kGP.vcf.gz") 
.Call("VCF_getSampleNames",vcf_handle) -> indv_names
