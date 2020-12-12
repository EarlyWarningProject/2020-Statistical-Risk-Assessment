# function to create training and test datasets for each base year
create_datasets <- function(dat, base_year = "2017"){
  foo <- subset(dat, select = c("sftgcode","year", outcomenames, 
                                predictornames, "country_name","year"))
  
  keep <- as.integer(base_year) - 2
  ### Train on all, though 2016 drops 
  
  
  yXtrain <- na.omit(foo) #drops years with NA any.mk variables
  yXtrain <- yXtrain[year <= keep]
  
  Xtrain <- subset(yXtrain, select = predictornames)
  ytrain_1yr <- subset(yXtrain, select = outcomenames[1]) #single leaded year outcome
  ytrain_2yr <- subset(yXtrain, select = outcomenames[2]) # two year window outcome
  
  # Prediction time data:
  Xtest <- na.omit(subset(dat[year == as.integer(base_year)], 
                          select =  c("sftgcode", "COWcode", predictornames, "country_name","year")))
  out <- list(Xtest, Xtrain, ytrain_1yr, ytrain_2yr)
  names(out) <- c("Xtest", "Xtrain", "ytrain_1yr", "ytrain_2yr")
  out
}