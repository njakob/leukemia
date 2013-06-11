
library("GA");



evaluate <- function(gene) {
  print(gene)
  1
}

# Launch genetic algorithm
GA <- ga(
  "permutation",
  min = 0,
  max = 1000,
  fitness = evaluate,
  maxiter = 1000,
  run = 200,
  popSize = 20,
  pcrossover = 0.8,
  pmutation = 0.1,
);

summary(GA);
plot(GA);
