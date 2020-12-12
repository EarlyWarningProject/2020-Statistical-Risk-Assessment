# function to format results, model embedded
format_results <- function(dat, base_year){
  dat_list <- create_datasets(dat, base_year = base_year)
  list2env(dat_list, .GlobalEnv)
  
  set.seed(123)
  risk.1yr <- model(ytrain = ytrain_1yr, Xtrain = Xtrain, Xtest = Xtest)
  set.seed(123)
  risk.2yr <- model(ytrain = ytrain_2yr, Xtrain = Xtrain, Xtest = Xtest)
  
  coeffs1 <- as.data.frame(as.matrix(risk.1yr[[2]]))
  coeffs1$vars <- rownames(coeffs1)
  coeffs2 <- as.data.frame(as.matrix(risk.2yr[[2]]))
  coeffs2$vars <- rownames(coeffs2)
  coeffs <- merge(coeffs1, coeffs2, by = "vars")
  colnames(coeffs) <- c("Variables", "Weights for 1-year forecast", "Weights for 2-year forecast")
  
  Xtest$risk.1yr <- risk.1yr[[1]]
  Xtest$risk.2yr <- risk.2yr[[1]]
  
  everything <- subset(Xtest,
                       select = c("country_name", "sftgcode", "COWcode", 
                                  "risk.1yr", "risk.2yr", predictornames))
  everything <- everything[order(everything$risk.1yr, decreasing = TRUE), ] 
  
  pred1 <- paste0("risk_in_", as.integer(base_year) + 1)
  pred2 <- paste(paste0("risk_in_", as.integer(base_year) + 1), 
                 substr(as.integer(base_year) + 2, 3, 4), sep = "_")
  
  colnames(everything)=c("country","SFTGcode","COW",pred1, pred2, predictornames)
  
  #including the cv.glment object
  cv.glmnet.2yr <- risk.2yr[[3]]
  
  out <- list(everything, coeffs, cv.glmnet.2yr)
  out
}