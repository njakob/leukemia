### params
datasetSize             <- 5000; # which dataset to use (1000,5000,10000)
maxGeneSelectionSize    <- 30;    # lower to emphasize smaller chromosomes from the first population; it takes 1 when 0 and 0 when 2*maxGeneSelectionSize
populationSize          <- 1000;
numGenerations          <- 100;
weight.chromosomeLength <- 0.1;   # higher to emphasize smaller chromosomes (less genes involved)
weight.accuracy         <- 0.3;   # higher to emphasize general classificator performance
weight.specificity      <- 0.6;   # higher to emphasize better crossed classification performance

# in cols, the guessed classes
# in rows, the actual classes
# matrix[actual,guessed] == the relative score of having guessed a class for the corrsponding actual value
scoreByClassesMatrix <- data.frame( 
  #c("real/guessed","AML","CML","ALL","CLL","NO"),
  #c(         "AML",  -  ,  -  ,  -  ,  -  ,  - ),
  #c(         "CML",  -  ,  -  ,  -  ,  -  ,  - ),
  #c(         "ALL",  -  ,  -  ,  -  ,  -  ,  - ),
  #c(         "CLL",  -  ,  -  ,  -  ,  -  ,  - ),
  #c(          "NO",  -  ,  -  ,  -  ,  -  ,  - )
  c(1.00, 0.25, 0.90, 0.10, 0.00),
  c(0.90, 1.00, 0.80, 0.70, 0.25),
  c(0.90, 0.10, 1.00, 0.25, 0.00),
  c(0.70, 0.80, 0.90, 1.00, 0.25),
  c(0.50, 0.75, 0.50, 0.75, 1.00)
);
colnames(scoreByClassesMatrix) <- c("AML","CML","ALL","CLL","NO");
rownames(scoreByClassesMatrix) <- c("AML","CML","ALL","CLL","NO");