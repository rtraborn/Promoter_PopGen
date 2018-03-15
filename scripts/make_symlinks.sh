vcfDir=/N/dc2/projects/PromoterPopGen/human/human-split-data

cd $vcfDir

for i in {1..22}; do
    echo "chr$i"
    cd gene_chr$i
    for vcf in ../human_${i}_*.vcf.gz
    do
	echo $vcf
	echo $(basename $vcf)
	#ln -s $vcf $(basename $vcf)
	ln -s ${vcf}.tbi $(basename $vcf).tbi
	done
cd ..
done    
