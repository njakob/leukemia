### dependencies
#install.packages("GA_1.1", type="source");
#install.packages("C50", type="source");
#install.packages("e1071", type="source");
library("GA");
library("C50");
library("e1071");

setwd("~/R workspace/Leukemia")

### params
datasetSize <- 10000;
maxGeneSelectionSize <- 50;
populationSize <- 200;
numGenerations <- 50;
chromosomeLenghtWeight <- 0.2;
classificationWeight <- 0.8;

### load data
data <- data.frame(
  read.csv(
    paste("data/allDataNoNAClass",datasetSize,".txt",sep=""),
    sep=""
  )
);
colnames(data) <- c( 1:datasetSize, "class");

input <- data[,1:datasetSize]
classes <- data[,datasetSize+1]

### genetic wrapper
source(file="common.R");
source(file="genetic_functions.R");

## Launch genetic algorithm
GA <- ga(
  "binary",
  nBits = ncol(input),
  #min = 0,
  #max = 1000,
  population = populate,
  fitness = evaluate,
  maxiter = numGenerations,
  #run = 200,
  popSize = populationSize,
  pcrossover = 0.8,
  pmutation = 0.1,
);

#print(summary(GA));
plot(GA);

# print genes
for (i in 1:nrow(GA@solution)){
  chromosome <- GA@solution[i,];
  print(paste("Best chromosome #:",i," with #",sum(chromosome)," genes"));
  print(getSelectedGenes(chromosome));
}
