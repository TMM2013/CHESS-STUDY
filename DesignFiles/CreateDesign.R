library(dplyr)
library(zoo)

set.seed(1234567890)
NumRuns <- 4
BlocksPerRun <- 32
BlockPairsPerRun <- BlocksPerRun/2

Blocks <- read_ods("./Blocks.ods")
Blocks$Used <- FALSE

# some initial randomization
for (i in 1:23) {
  Order <- c(sample(32), sample(33:64), sample(65:96), sample(97:128))
}
Blocks <- Blocks[Order, ]

# first we need to randomize block lengths
Seq1 <- rep(c("NV", "PL"), BlockPairsPerRun)
Seq2 <- rep(c("PL", "NV"), BlockPairsPerRun)
OrderedBlocks <- data.frame(
  Run=Blocks$Run, 
  NumTrials=NA, 
  Condition=c(Seq1, Seq2, Seq2, Seq1)
)
OrderedBlocks <- split(OrderedBlocks, OrderedBlocks$Run)

# for (i in 1:nrow(OrderedBlocks) {
#   
# 
# DefaultPair <- data.frame(
#   Run=rep(NA, 
# 
# Images <- read_ods("./Images.ods")
# AvailNV <- which(Images$Type == "NV")
# AvailPL <- which(Images$Type == "PL")
# 
#   
# 
# Design <- replicate(NumRuns, data.frame(), simplify=F)
# 
# for (i in 1:nrow(Blocks)) {
#   if (Blocks$Condition[i] == "NV" ) {
#     TmpIndex <- sample.int(length(AvailNV), Blocks$NumTrials[i])
#     ImgIndex <- AvailNV[TmpIndex]
#     AvailNV <- AvailNV[-1*TmpIndex]
#   } else {
#     TmpIndex <- sample.int(length(AvailPL), Blocks$NumTrials[i])
#     ImgIndex <- AvailPL[TmpIndex]
#   }
#     
#   Design[[Blocks$Run[i]]] <- rbind(Design[[Blocks$Run[i]]],
#     data.frame(
#       Run=Blocks$Run[i],
#       Condition=Blocks$Condition[i],
#       BlockNum=Blocks$BlockNum[i],
#       FileName=Images$FileName[ImgIndex]
#     )
#   )
# }
# 
# Design <- bind_rows(Design)
# write.csv(Design, file="../Design.csv", row.names=F, quote=F)
