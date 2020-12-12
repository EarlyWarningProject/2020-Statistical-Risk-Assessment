# function to run model 
model <- function(ytrain, Xtrain, Xtest, alpha = .5){
  
  elastic.cv <- cv.glmnet(y=unlist(ytrain),  
                          x=as.matrix(subset(Xtrain, 
                                             select = predictornames)), 
                          alpha=alpha, family="binomial")
  coeffs <- coef(elastic.cv, s = "lambda.min")
  
  elastic.predictions = signif(predict(elastic.cv,
                                       newx=as.matrix(subset(Xtest, select = predictornames)), 
                                       s="lambda.min", type="response"),4)
  
  risk <- as.numeric(elastic.predictions)
  out <- list(risk, coeffs, elastic.cv)
  out
}