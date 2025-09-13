rm(list = ls()) # clear the environment

library(compositions)
library(glmnet)

# setwd("C:/Users/nrios4/OneDrive - George Mason University - O365 Production/Masters Students/Aaron Pongsugree")
setwd("~/GMU/Masters Students/Aaron Pongsugree")

# change the directory to the location of the otu and task files
# task <- read.delim("C:/Users/riosn/OneDrive/Desktop/taskcancer.txt", header=TRUE)
task <- read.delim("taskcancer.txt", header = TRUE)
colnames(task) = c("SampleID","y","SubjectID")
# there were 2 observations per subject: one was healthy tissue and one had a tumor
# the subject ID indicates the ID number for each subject. 
# the problem is by default, R adds an "X" to column variables that start with numbers
# so we need to set check.names = FALSE
# otuex2 <- read.delim("C:/Users/riosn/OneDrive/Desktop/otutable.txt", header=TRUE, check.names = FALSE)
# otuex2 <- read.delim("C:/Users/nrios4/OneDrive - George Mason University - O365 Production/Masters Students/Aaron Pongsugree/otutable.txt", 
#                      header = TRUE, check.names = FALSE)
otuex2 <- read.delim("otutable.txt", 
                     header = TRUE, check.names = FALSE)
OTU = otuex2[,1]
count_data = t(otuex2[,-1])
colnames(count_data) = OTU


# All of these should be true, i.e., all of the sample IDs should come up in the dataset
# match_ids = sapply(task$SampleID, function(x) x %in% rownames(count_data))


SampleID = rownames(count_data)

# Create true_y vector
true_y = rep(NA,nrow(count_data))
subject_id = rep(NA,nrow(count_data))
for(i in 1:nrow(count_data)){
  if(SampleID[i] %in% task$SampleID){
    true_y[i] = task$y[task$SampleID == SampleID[i]]
    subject_id[i] = task$SubjectID[task$SampleID == SampleID[i]]
  }
}
y = true_y
count_data_all = as.data.frame(cbind(SampleID, y, subject_id, count_data))
count_data_clean = count_data_all[complete.cases(count_data_all),]
View(count_data_clean)
# write.csv(count_data_clean,"count_data_clean.csv")

#### Approach 1: Just use the count data + lasso
cv_count1 = cv.glmnet(x = count_data[complete.cases(count_data_all),], y = count_data_clean$y, family = "binomial")
count.glm.out = glmnet(x = count_data[complete.cases(count_data_all),], y = count_data_clean$y, family = "binomial",
                       lambda = cv_count1$lambda.min)
which(count.glm.out$beta != 0)
colnames(count_data[,which(count.glm.out$beta != 0)])
count.glm.out$beta[which(count.glm.out$beta != 0)]

#### Approach 2: Use the ALR transformation
comp_data = count_data
for(i in 1:nrow(count_data)){
  comp_data[i,] = count_data[i,]/sum(count_data[i,])
}
rowSums(comp_data)
comp_data_all = as.data.frame(cbind(SampleID,y,subject_id,comp_data))
comp_data_clean = comp_data_all[complete.cases(comp_data_all),]
# write.csv(comp_data_clean,"comp_data_clean.csv")

alr_comp_data = alr(comp_data + 1e-30)
alr_comp_data_clean = alr_comp_data[complete.cases(comp_data_all),]

set.seed(123)
cv_glm1 = cv.glmnet(x = alr_comp_data_clean, y = comp_data_clean$y, family = "binomial")
glm.out = glmnet(x = alr_comp_data_clean, y = comp_data_clean$y, family = "binomial", lambda = cv_glm1$lambda.min)
which(glm.out$beta != 0)


##### Things to try:
### Consider other methods, such as:
# FLORAL: https://cran.r-project.org/web/packages/FLORAL/readme/README.html 
# Robust Logistic Regression for Compositional Data. R package here: https://github.com/giannamonti/RobZS 
# R package for FLORAL is available

# both of the above methods are similar to/based on this work:
# Lin et al 2014: Variable selection in regression with compositional covariates: https://academic.oup.com/biomet/article/101/4/785/1775476

### Which method has better accuracy? Sensitivity? (True Pos Rate) Specificity? (True Neg Rate)
# Evaluate using a test-train split
