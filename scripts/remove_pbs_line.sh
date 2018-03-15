scriptDir=/N/dc2/projects/PromoterPopGen/DmPromoterPopGen/scripts

cd $scriptDir

for file in `ls PopGenome_batch_chr*.sh`; do
	echo $file
	sed -i '/#PBS -m abe/d' $file
    done    
