# 2020-Statistical-Risk-Assessment

Replication files for the 2020 edition of USHMM's statistical risk assessment. 

You should use the data stored in the repo, "prepared2019predictors-2020-08-10.RData". This is preferable to regenerating the data yourself, since doing so requires a host of anciliary files, pulling data from online sources, etc. We nevertheless include a folder containing the R files used to make the data (Make Data), for reference and replicability. Within this folder:

- "Adding in new data" is an R Markdown file that appends data for each country in 2019 to the prepared data through 2018.
- The input folder contains the data prepared through 2018 from last year's analysis: "prepared2018predictors_2_11_20.RData"
- The output folder contains the prepared data, updated through 2019: "prepared2019predictors-2020-08-10.RData"

The main files of interest are likely in the Modelling folder. 

- "run model" is an R Markdown file that takes the latest data ("prepared2019predictors-2020-08-10.RData") and generates forecasts. It allows you to input a vector of base years, from which you would like to generate one and two-year forecasts. The most relevant forecasts have been included in the results folder, generated from base year 2019, predicting outcomes in the next year (2020) and in the next two years (2020 and 2021). Note that if you choose to run the model for base years earlier than 2016, there is some missingness in the data that will prevent you from getting predicted probabilities for all 162 of the countries.
- "base2019-run-2020-08-18" and "base2019-coeffs-run-2020-08-18" are the outputs of the "run model" file. The former file shows the predicted probabilities for each country, and the latter shows the weights for each of the predictors selected. 
