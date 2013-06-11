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
  
  count <- sum(x);
  
  # one gene at least!
  if (count == 0){
    print("Empty chromosome!");
    return(0);
  }
  else {
    # so that the center is on maxGeneSelectionSize
    m = (1/maxGeneSelectionSize);
    
    # get the scores
    lenghtScore = 1+m - m*count;
    classificationScore = getClassificationEvaluation(x);
    
    # weight and add
    score = lenghtScore * chromosomeLenghtWeight + classificationScore * classificationWeight;

    print(paste("Classification score:",classificationScore));
    
    return(score);
  }
  
}

## Interfaces the classificator to get a real evaluation
getClassificationEvaluation <- function(x) {  
  # translate chromosome into genes list
  genes <- getSelectedGenes(x);

  # filter out the columns not selected by the chromosome
  filteredData <- data[,genes];
  filteredData$class <- data$class;

  # prepare validation & training datasets
  validationData <- filteredData[sample(nrow(filteredData), round(nrow(data)*0.33)),];
  trainingData <- filteredData[setdiff(rownames(filteredData), rownames(validationData)),];
  classified <- getClassifiedResults(trainingData,validationData);

  return(getScore(classified,validationData$class));
}

## Creates a learner and classifies 
getClassifiedResults <- function(trainingData,validationData){
  return(getClassifiedResultsKNN(trainingData,validationData));
}

getClassifiedResultsKNN <- function(trainingData,validationData){
  return( knn(trainingData[,-ncol(trainingData)], validationData[,-ncol(validationData)], trainingData$class) );
}

## SVM learner
getClassifiedResultsSVM <- function(trainingData,validationData){
  learner = svm(trainingData[,-ncol(trainingData)], trainingData$Class);
  
  predictor <- predict(learner, validationData[,-ncol(validationData)]);
  
  return(predictor);  
}

# C5 learner
getClassifiedResultsC5 <- function(trainingData,validationData){
  # now call the C5.0 algorithm
  learner <- C5.0(x = trainingData[,-ncol(trainingData)], y = as.factor(trainingData$class));
  
  # and predict!
  predictor <- predict(learner, validationData[,-ncol(validationData)]);
  return (predictor);
}

## Calculates the score according to the classificator results
getScore <- function(classified,classes){
  
  correct <- length(which(classified == classes))
  total <- length(classified)
  
  score <- correct/total;
  
  return (score);
}
