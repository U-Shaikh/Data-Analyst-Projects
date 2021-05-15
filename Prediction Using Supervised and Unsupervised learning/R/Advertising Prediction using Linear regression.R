# Packages
# library(tidyverse)  # data manipulation and visualization
# library(modelr)     # provides easy pipeline modeling functions
# library(broom)      # helps to tidy up model outputs

library(mongolite)
#mongodb Connection
m = mongo("Advertisingdb",url = "mongodb://127.0.0.1:27017/Advertising")
#m$insert('{"name": "Anag","jutsu":"air"}')
#Logistic regression for student application
#find all rows
n<-m$find('{}')
#get a glimpse (idea)
dplyr::glimpse(n)
head(n)

str(n)

fit1 <- lm(sales ~ TV, data = data)

require(ggplot2)
require(ggthemes)
ggplot1 <- ggplot() +
  # geom_smooth(data = data, aes(x = TV, y = sales), method = "lm", se = FALSE, color = "lightgrey") +
  geom_point(aes(x = data$TV, y = fit1$fitted.values), shape = 1, alpha = 0.2) +
  geom_segment(aes(x = data$TV, xend = data$TV, y = fit1$fitted.values, yend = data$sales)) +
  geom_point(data = data, aes(x = TV, y = sales), color = "red") +
  theme_tufte()

knitr::kable(summary(fit1)$coef)

par(mfrow=c(2,2))
plot(fit1)


fit2 <- lm(sales ~ newspaper, data = data)
knitr::kable(summary(fit2)$coef)

#linear regression
data <- data[, -1] # the X1 variable is merely a counting variable
fit3 <- lm(sales ~ ., data = data)
knitr::kable(summary(fit3)$coef)

pairs(data) # with a plot

# it looks nice...but let's stick with the numbers
knitr::kable(cor(data)) # with numbers

require(corrplot)
#> Loading required package: corrplot
#> Warning: package 'corrplot' was built under R version 3.3.3
cordata <- cor(data)
corrplot.mixed(cordata)


plot(fit3, which=c(1,1))

fit4 <- lm(sales ~ (TV + radio + newspaper)^2, data = data)
knitr::kable(summary(fit4)$coef) 


plot(fit4, which=c(1,1))

RSE <- c(summary(fit1)$sigma, summary(fit3)$sigma, summary(fit4)$sigma)
Rsquared <- c(summary(fit1)$r.squared, summary(fit3)$r.squared, summary(fit4)$r.squared)
overview <- data.frame(RSE, Rsquared)
rownames(overview) <- c("fit1", "fit3", "fit4")

knitr::kable(t(overview))
