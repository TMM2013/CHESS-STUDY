library(dplyr)
library(zoo)
library(readODS)
library(ggplot2)

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

for (i in 1:NumRuns) {
  AvailPL <- filter(Blocks, Condition == "PL", Run == i)$NumTrials
  AvailNV <- filter(Blocks, Condition == "NV", Run == i)$NumTrials

  AvailPL <- sample(AvailPL, length(AvailPL))
  AvailNV <- sample(AvailNV, length(AvailNV))

  OrderedBlocks[[i]]$NumTrials[OrderedBlocks[[i]]$Condition == "PL"] <- AvailPL
  OrderedBlocks[[i]]$NumTrials[OrderedBlocks[[i]]$Condition == "NV"] <- AvailNV
}
OrderedBlocks <- bind_rows(OrderedBlocks)
OrderedBlocks <- OrderedBlocks %>%
  group_by(Run) %>%
  mutate(BlockNum=1:n())

Images <- read_ods("./Images.ods")
AvailNV <- which(Images$Type == "NV")
AvailPL <- which(Images$Type == "PL")
Design <- data.frame()

for (i in 1:nrow(OrderedBlocks)) {
  if (OrderedBlocks$Condition[i] == "NV" ) {
    TmpIndex <- sample.int(length(AvailNV), OrderedBlocks$NumTrials[i])
    ImgIndex <- AvailNV[TmpIndex]
    AvailNV <- AvailNV[-1*TmpIndex]
  } else {
    TmpIndex <- sample.int(length(AvailPL), OrderedBlocks$NumTrials[i])
    ImgIndex <- AvailPL[TmpIndex]
  }
    
  Design <- rbind(Design,
    data.frame(
      Run=OrderedBlocks$Run[i],
      Condition=OrderedBlocks$Condition[i],
      BlockNum=OrderedBlocks$BlockNum[i],
      NumTrials=OrderedBlocks$NumTrials[i],
      FileName=Images$FileName[ImgIndex]
    )
  )
}

Design <- Design %>%
  group_by(Run) %>%
  mutate(TrialNum = 1:n())

write.csv(Design, file="../Design.csv", row.names=F, quote=F)

# let's make a plot just because
Design$All <- 1
p <- ggplot(Design, aes(BlockNum, All, color=Condition)) +
  geom_count() +
  facet_grid(Run ~ .)
  

