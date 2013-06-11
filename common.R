getSelectedGenes <- function(chromosome){
  return(colnames(input)[chromosome==1])
}

createSuperClassesInData <- function(data){
  # global object data
  cllClass <- which(data$class=="leukemia class: CLL");
  allClass <- c( 
    which(data$class=="leukemia class: T-ALL"),
    which(data$class=="leukemia class: B-ALL"),
    which(data$class=="leukemia class: ALL with t(12;21)"),
    which(data$class=="leukemia class: ALL with t(1;19)"),
    which(data$class=="ALL with hyperdiploid karyotype")
  );
  amlClass <- which(data$class=="leukemia class: AML");
  cmlClass <- which(data$class=="leukemia class: CML");
  
  data$class <- "NO";
  data[cllClass, "class"] <- "CLL";
  data[allClass, "class"] <- "ALL";
  data[amlClass, "class"] <- "AML";
  data[cmlClass, "class"] <- "CML";  
  
  return(data)
}
