#manually enter paths, files, file attributes etc
feature.file <- file.path("C:\\File\\Path\\Here", "features.gtf")
bam_dir <- "C:\\Dir\\To\\BAM\\Files\\Here"
bam.files <- list.files(path=bam.dir, recursive = T, pattern = "\\.bam$")
feature.select <- c("Name","product","locus_tag") #feature attributes to select
strand <- 0 #0=not strand specific, 1 or 2 = specific strand
large.overlap <- TRUE #assign to feature with largest no. of overlapping bases
feature.type <- "CDS" #feature type to use for alignment
is.gtf <- TRUE #is the feature file a GTF file
feature.identifier <- "transcript_id" #feature attribute to use as unique identifier
is.paired <- TRUE #sequences are paired reads
is.map.both.ends <- FALSE #require that both ends be mapped
is.multi.map <- TRUE #allow multi-mapping to multiple features
sample.names <- c("TX0r1","TX0r2","TX0r3","TX48r1","TX48r2","TX48r3","RZ0r1","RZ0r2","RZ0r3","RZ48r1","RZ48r2","RZ48r3") #will become column names of read count dataframe

#call featureCounts for each bam.files
library("Rsubread")
readCounts <- featureCounts(files = bam.files, annot.ext = feature.file, useMetaFeatures = TRUE, GTF.attrType.extra = feature.select, strandSpecific = strand,
                            largestOverlap = large.overlap, GTF.featureType = feature.type, isGTFAnnotationFile = is.gtf, GTF.attrType = feature.identifier,
                            isPairedEnd = is.paired, requireBothEndsMapped = is.map.both.ends, countMultiMappingReads = is.multi.map)
#if there are many bam.files it may take a long time so, call featureCounts manually in case there is an issue in one of the files
ind <- 1 #manually change this to an index of bam.file
assign(paste("count",ind),
       featureCounts(files=bam.files[ind], annot.ext=genomeFile, useMetaFeatures=TRUE, GTF.attrType.extra=feature.select, strandSpecific=strand,
                     largestOverlap=large.overlap, GTF.featureType=feature.type, isGTFAnnotationFile=is.gtf, GTF.attrType=feature.identifier,
                     isPairedEnd=is.paired, requireBothEndsMapped=is.map.both.ends, countMultiMappingReads=is.multi.map))
#if doing manual calls, check that the row order is the same
sapply(lapply(ls(pat="count"), function(x) rownames(x$counts)), FUN = identical, rownames(count1$counts))

#clean up read count dataframe
#if doing manual calls, use merge to join individual count dataframes into one dataframe
count.df <- expr.data <- Reduce(function(x,y) transform(merge(x = x, y = y, by = 0, all = T), row.names=Row.names, Row.names=NULL), lapply(ls(pat="count"), function(x) x$counts))
colnames(count.df) <- sample.names

#write read counts to csv file
write.csv(count.df, file.path("C:\\Output\\Dir\\Here","read_counts.csv"), row.names = T)
