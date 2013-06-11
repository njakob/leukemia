### dependencies
#install.packages("GA_1.1", type="source");
library("GA");

### params
datasetSize <- 1000;
maxGeneSelectionSize <- 50;

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

## initial population
populate <- function(ga){
  
  results <- matrix(0,nrow=ga.popsize,ncol=datasetSize)
  
  for ( j in 1:ga.popsize){  
    # get some random genes (positions in the chromosome)
    genes <- sample(1:datasetSize,maxGeneSelectionSize);
    
    # then set them to 1
    for ( i in (1:maxGeneSelectionSize) ) {
      results[j,genes[i]] = 1;
    }

  }
  
  return(results); 
}

## evaluation function
evaluate <- function(x,y) {

  # x <- c(1,0,1,....) # size limit set before
  if (sum(x) > maxGeneSelectionSize) {
    print("too big");
    return (0); # TODO: set a regressive formula
  } else if (sum(x) < maxGeneSelectionSize - 5){
    return (1);
  } else {
    return(runif(1,0,1));
  }    
  
}

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
  popSize = 20,
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
