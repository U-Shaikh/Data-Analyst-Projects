library(mongolite)

#mongodb Connection
m = mongo("Arrestdb",url = "mongodb://127.0.0.1:27017/USArrest")
#m$insert('{"name": "Anag","jutsu":"air"}')
#Logistic regression for student application
#find all rows
us_arrests<-m$find('{}')
#get a glimpse (idea)
dplyr::glimpse(data)
head(us_arrests)



str(us_arrests)

summary(us_arrests)

sus_arrests<-scale(us_arrests)
head(sus_arrests)


set.seed(123)
kus_arrests<-kmeans(sus_arrests, centers = 4, nstart = 50)
#Simple visualisation of clusters 
plot(x=sus_arrests[,1], y=sus_arrests[,2], col=kus_arrests$cluster)
points(kus_arrests$centers, pch=3, cex=2)

library(cluster)
clusplot(sus_arrests, kus_arrests$cluster, color = T, labels = 2, main = 'Cluster Plot')


plot(silhouette(kus_arrests$cluster, dist = dist_data), col=2:5)

PAMus_arrests<-pam(sus_arrests, 4)
clusplot(sus_arrests, PAMus_arrests$clustering, color = T, main = 'Cluster Plot')

kmax<-10
WSSus_arrests<-sapply(1:kmax, function(k) kmeans(sus_arrests, centers = k, nstart = 10)$tot.withinss)

plot(1:kmax, WSSus_arrests, type = 'b', xlab = 'k', ylab = 'Total wss')
abline(v=4, lty=2)