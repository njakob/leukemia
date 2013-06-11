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
    return (0.1); # TODO: set a regressive formula
  } else if (sum(x) < maxGeneSelectionSize - 5){
    return (1);
  } else {
    return(getEvaluation(x));
  }    
  
}

## Interfaces the classificator to get a real evaluation
getEvaluation <- function(x) {  
  # translate chromosome into genes list
  genes <- getSelectedGenes(x);
  
  # filter out the columns not selected by the chromosome
  filteredData <- data[,genes];
  filteredData$class <- data$class;

  # prepare validation & training datasets
  validationData <- filteredData[sample(nrow(filteredData), round(nrow(data)*0.33)),]
  trainingData <- filteredData[setdiff(rownames(filteredData), rownames(validationData)),]  
  
  # now call the C5.0 algorithm
  learner = C5.0(x = trainingData[,-ncol(trainingData)], y = as.factor(trainingData$class));
  
  # and predict!
  classified = predict(learner, validationData[,-ncol(validationData)]);
  
  return(getScore(classified,validationData$class));
}

## Calculates the score according to the classificator results
getScore <- function(classified,classes){
  
  correct <- length(which(classified == classes))
  total <- length(classified)
  
  score <- correct/total;
  
  print(paste("score:",score));
  
  return (score);
}
