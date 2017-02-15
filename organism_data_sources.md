## Species
1. arabidopsis 
	1. [1001 Genomes](http://1001genomes.org/index.html)
	2. [Reference](https://www.arabidopsis.org/doc/portals/genAnnotation/gene_structural_annotation/ref_genome_sequence/11413)
	3. 1001 genomes has the full genomes for 1100 strains so might not need the reference (132 Gb)
2. c elegans 
	1. [CeNDR](https://www.elegansvariation.org/strain/)
	2. [reference](http://hgdownload.cse.ucsc.edu/downloads.html)
	3. VCF is about 2 Gb but it is possible to download all alignment data (not sure of the size)
3. humans 
	1. [1000 Genomes](http://www.internationalgenome.org/)
	2. [reference](http://hgdownload.cse.ucsc.edu/downloads.html)
	3. Lots of options - not sure which files to use
4. mouse - 17 sequences , Paper for another dataset - dataset ,  reference​
	1. [Mouse Genome Project](http://www.nature.com/articles/sdata201675)
	2. ftp download site: ftp://ftp-mouse.sanger.ac.uk/
	3. [reference](http://hgdownload.cse.ucsc.edu/downloads.html)
	4. 21 Gb for the variants (REL-1505-SNPs_Indels)
5. yeast
	1. [Yeast Genome Project](http://www.yeastgenome.org/download-data/sequence)
	2. [reference](http://www.yeastgenome.org/download-data/sequence)
	3. [reference](http://hgdownload.cse.ucsc.edu/downloads.html)



strain issues - Is it a good idea to assume all strains as a single population? If not, we might not have strong results for yeast and arabidopsis

How to use this data - All of these contain VCF files (variant crossed with population), thus the actual sequence is not given. What we can do is:
    1. Acquire the promoter regions for each organism
    2. Find the variants within the region
    3. Get the monomorphic parts of the sequence from the reference genome
    4. Calculate H values