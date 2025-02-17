

rm(list=ls())

library(readr)
library(dplyr)
library(stringr)

args <- commandArgs(T)
for(i in 1:length(args)){ eval(parse(text=args[[i]])) }

annota <- read_tsv('/dcs04/nilanjan/data/jzhang2/pwas/pipeline/Results_GRCh38/prot.anno_autosomal.txt')
seqid <- readLines("/dcs04/nilanjan/data/jzhang2/pwas/pipeline/Results_GRCh38/White/window1M/seqid_autosomal_withSNP.txt")

for (i in 1:length(seqid)){
  gene <- seqid[i]

  tmp <- read.table(paste0("/dcs04/nilanjan/data/jzhang2/pwas/pipeline/Results_GRCh38/White/pQTL/White_matchNblack/Random_10times/invrankpheno/",r,"/", gene, ".pheno"))
  if(i==1){
    tmp <- t(tmp)[-1,]
    res <- cbind(rbind(c("#Chr" ,"start" ,"end", "pid", "gid", "strand"),
                       c(annota$chromosome_name[annota$seqid_in_sample==gene],
                         annota$transcription_start_site[annota$seqid_in_sample==gene],
                         annota$transcription_start_site[annota$seqid_in_sample==gene]+1,
                         gene, gene, "+")),
                 tmp)
  }else{
    tmp <- t(tmp)[-1:-2,]
    tmp <- c(annota$chromosome_name[annota$seqid_in_sample==gene],
             annota$transcription_start_site[annota$seqid_in_sample==gene],
             annota$transcription_start_site[annota$seqid_in_sample==gene]+1,
             gene, gene, "+", tmp)
    res <- rbind(res, tmp)
  }

  print(i)
}
res1 <- as.data.frame(res, stringsAsFactors = F)
colnames(res1) <- res1[1,]; res1 <- res1[-1,]
rownames(res1) <- NULL
write_tsv(res1, paste0("/dcs04/nilanjan/data/jzhang2/pwas/pipeline/Results_GRCh38/White/pQTL/White_matchNblack/Random_10times/bed_file/",r,"/allchr.bed"))


for(i in 1:22){
  tmp <- res1[res1[["#Chr"]] == i,]
  tmp$start <- as.integer(tmp$start)
  tmp <- tmp[order(tmp$start,decreasing=F),]
  write_tsv(tmp, paste0("/dcs04/nilanjan/data/jzhang2/pwas/pipeline/Results_GRCh38/White/pQTL/White_matchNblack/Random_10times/bed_file/",r,"/chr",i,".bed"))
  print(i)
}

