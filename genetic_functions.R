#######################################
##### Genetic algorithm functions #####
#######################################

## initial population
populate <- function(ga){
  
  results <- matrix(0,nrow=populationSize,ncol=datasetSize)
  
  for ( j in 1:populationSize){  
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