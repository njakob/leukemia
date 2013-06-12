### dependencies
#install.packages("GA_1.1", type="source");
#install.packages("C50", type="source");
#install.packages("e1071", type="source");
library("GA");
library("C50");
library("e1071");

setwd("~/R workspace/Leukemia")

source(file="common.R");
source(file="genetic_functions.R");
source(file="config.R");

### load data
data <- data.frame(
  read.csv(
    paste("data/allDataNoNAClass",datasetSize,".txt",sep=""),
    sep=""
  )
);
colnames(data) <- c( 1:datasetSize, "class");

### pre-process it to extract main leukemia classes
data <- createSuperClassesInData(data);

input <- data[,1:datasetSize]
classes <- data[,datasetSize+1]

### genetic wrapper

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
  elitism = 0.01,
  pmutation = 0.2,
);

#print(summary(GA));
plot(GA);

# print genes
for (i in 1:nrow(GA@solution)){
  chromosome <- GA@solution[i,];
  print(paste("Best chromosome: #",i," with ",sum(chromosome)," genes",sep=""));
  print(getSelectedGenes(chromosome));
}
