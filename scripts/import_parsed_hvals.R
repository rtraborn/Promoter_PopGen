
#### This script imports the parsed h-value data from all populations and creates a list file which is then saved in the user's workspace

fileDir <- "/N/dc2/projects/PromoterPopGen/Xuan/h_matrix/Parsed_results"

h_files <- list.files(path=fileDir, pattern="\\.tsv$", full.names=TRUE)

h_list <- vector(mode="list", length=length(h_files))

	for (i in 1:length(h_files)) {
	    this.file <- h_files[i]
	    this.h <- read.table(this.file, header=FALSE, skip=1)
	    colnames(this.h) <- c("chr","start","end","nTSSs","nTags", "width", "SI", "majorTSS", "ID", "windowPos", "h_value")
	    this.h$pop <- basename(this.file)
	    h_list[[i]] <- this.h
	    
}

save(h_list, file="hList.RData")
combined.df <- do.call(rbind, h_list)
write.table(combined.df, file="h_values_positions_total.txt", sep="\t")