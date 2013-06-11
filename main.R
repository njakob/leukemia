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
input <- data[,1:1000]
classes <- data[,1001]

### genetic wrapper

## evaluation function
evaluate <- function(x) {
  # x <- c(1,0,1,....) # size limit set before
  if (sum(x) > 50)
    return (0) # TODO: set a regressive formula
  else
    return(1);
  
  # genes <- dataset[,x=1]
  
  # current_solution_survivalpoints <- x %*% input[1,]
  #survivalpoints current_solution_weight <- x %*% dataset$weight  if (current_solution_weight > weightlimit)  return(0) else return(-current_solution_survivalpoints)
}

## Launch genetic algorithm
GA <- ga(
  "binary",
  nBits = ncol(input),
  #min = 0,
  #max = 1000,
  fitness = evaluate,
  maxiter = 1000,
  run = 200,
  popSize = 20,
  pcrossover = 0.8,
  pmutation = 0.1,
);

summary(GA);
plot(GA);
