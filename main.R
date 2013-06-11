### dependencies
#install.packages("GA_1.1", type="source");
library("GA");

### params
datasetSize <- 1000;
maxGeneSelectionSize <- 50;
populationSize <- 20;

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
source(file="genetic_functions.R");

## Launch genetic algorithm
GA <- ga(
  "binary",
  nBits = ncol(input),
  #min = 0,
  #max = 1000,
  population = populate,
  fitness = evaluate,
  maxiter = 1000,
  run = 200,
  popSize = populationSize,
  pcrossover = 0.8,
  pmutation = 0.1,
);

#print(summary(GA));
plot(GA);

# print genes
for (i in 1:nrow(GA@solution)){
  chromosome <- GA@solution[1,];
  print(paste("Best chromosome #:",i," with #",sum(chromosome)," genes"));
  print(colnames(input)[chromosome==1]);
}
