# r-featureCounts
Use featureCounts in R to get read counts from bam or sam files using a genome feature file such as gtf.

The calling of featureCounts is done via the [Rsubread](https://www.bioconductor.org/packages/release/bioc/html/Rsubread.html) library. Please [check their documentation](https://www.rdocumentation.org/packages/Rsubread/versions/1.22.2/topics/featureCounts) to understand what you need to set the parameters to.

It may be helpful to check the bam or sam files before using featureCounts by using a [genome assembly viewer](https://igv.org/), and making sure that there is adequate coverage of sequence data.

The [Rsubread](https://www.bioconductor.org/packages/release/bioc/html/Rsubread.html) wrapper accepts saf and gtf/gff feature files. Gff feature files can be downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/nuccore) or from a genome database of your choice. However, it may be necessary to convert gff to gtf file formatting. In R, this can be done with the [rtracklayer](https://www.bioconductor.org/packages/release/bioc/html/rtracklayer.html) library.
