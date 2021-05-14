library(datasets)
library(ggplot2)
library(dplyr)
library(rio)

library(mongolite)
#mongodb Connection
m = mongo("Studentdb",url = "mongodb://127.0.0.1:27017/StudentsGrades")
#m$insert('{"name": "Anag","jutsu":"air"}')
#Logistic regression for student application
#find all rows
data<-m$find('{}')
#get a glimpse (idea)
dplyr::glimpse(data)
head(data)

str(data)
data
data$ADMIT <- as.factor(data$ADMIT)
data$RANK <- as.factor(data$RANK)
str(n)


summary(data)

plot(data$GPA,data$GRE,col="red")

cor(data$GRE,data$GPA)

#Since GRE is numeric variable and dependent variable is factor variable, we plot a box plot.
ggplot(data,aes(ADMIT,GRE,fill=ADMIT))+
  geom_boxplot()+
  theme_bw()+
  xlab("Admit")+
  ylab("GRE")+
  ggtitle("ADMIT BY GRE")

#The two box plots are differents in terms of displacement, and hence GRE is significant variable.
ggplot(data,aes(ADMIT,GPA,fill=ADMIT))+
  geom_boxplot()+
  theme_bw()+
  xlab("Admit")+
  ylab("GPA")+
  ggtitle("ADMIT BY GPA")

#RANK is a factor variable and since the dependent variable is a factor variable we plot a bar plot.

ggplot(data,aes(RANK,ADMIT,fill=ADMIT))+
  geom_col()+
  xlab("RANK")+
  ylab("COUNT-ADMIT")+
  ggtitle("ADMIT BY RANK")

library(caret)  #For data spliting
set.seed(125)   #For reproducibiity
ind <- createDataPartition(data$ADMIT,p=0.80,list = FALSE)
training <- data[ind,] #training data set
testing <- data[-ind,] #Testing data set

set.seed(123)
mymodel <- glm(ADMIT~GPA + RANK,data=training,family=binomial(link = "logit"))
summary(mymodel)

pred <- predict(mymodel,testing,type = "response")
pred <- ifelse(pred>=0.5,1,0)

pred <- as.factor(pred)
confusionMatrix(pred,testing$ADMIT)

llibrary(lares)
tag.1 <- as.numeric(testing$ADMIT)
score.1 <- as.numeric(pred)
mplot_roc(tag=tag.1,score=score.1)


#Goodness-of-fit-test
with(mymodel,pchisq(null.deviance-deviance,df.null-df.residual,lower.tail = F))






