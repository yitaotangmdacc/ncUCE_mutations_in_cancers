# R v4.2.2

library(Gviz)
library(rtracklayer)
library(biomaRt)

h3k27ac <- import.bw("ENCFF142EKL.bigWig", as="GRanges")
h3k27me3 <- import.bw("ENCFF977LFP.bigWig", as="GRanges")

enh <- DataTrack(h3k27ac, genome="hg19", chomosome="chr6", name="normalized H3K27ac", 
                 type="mountain", ylim=c(0,6), 
                 col.mountain="#6d86fc", fill.mountain=c("#6d86fc", "#6d86fc"))
sln <- DataTrack(h3k27me3, genome="hg19", chomosome="chr6", name="normalized H3K27me3", 
                 type="mountain", ylim=c(0,6), 
                 col.mountain="#f7bf5e", fill.mountain=c("#f7bf5e", "#f7bf5e"))

aTrack <- AnnotationTrack(start=157275014, width=110, chromosome="chr6", strand="*",
                          group = "UCE_11311", genome = "hg19", name = "UCE_11311", 
                          col.line='grey', fill='grey', cex=0.5, 
                          showId=TRUE, fontcolor.group="black")

axisTrack <- GenomeAxisTrack()
ideoTrack <- IdeogramTrack(genome = "hg19", chromosome = "chr6")

bm <- useEnsembl(host = "https://grch37.ensembl.org", 
              biomart = "ENSEMBL_MART_ENSEMBL", 
              dataset = "hsapiens_gene_ensembl")
biomTrack <- BiomartGeneRegionTrack(genome = "hg19", chromosome = "chr6", 
                                    start = 157274014, end = 157276124,
                                    name = "ENSEMBL", biomart = bm)

tiff('fig3b.tiff', 720, 720, res=200)
plotTracks(list(ideoTrack, axisTrack, aTrack, enh, sln), 
           from=157274014, to=157276124, 
           background.title = "white", col.title="black", col.axis="black")
dev.off()

