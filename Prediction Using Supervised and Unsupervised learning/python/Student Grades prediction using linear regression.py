# -*- coding: utf-8 -*-
"""
Created on Sat Apr 24 22:15:04 2021

@author: Abc
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pymongo
from pymongo import MongoClient

 
#connection = MongoClient('localhost',27017)
#mydb =connection['Students']
#mycol =mydb['StudentDatabase']

#Now creating a cursor instance
#using find() function
#cursor=mycol.find()
#print('Type of cursor:',type (cursor))

#Converting cursor to the list of dictionaries
#list_cur =list(cursor)

#Converting to the dataframe
#df = pd.DataFrame(list_cur)
#print('Type of cursor:',type (df))

#other way
connection =MongoClient('localhost',27017)
db =connection.StudentDatabase
data = db.Students
StudentList = data.find()

for item in StudentList:
    print(item)
    #print(" " +item["study_hours"] + " "+item["student_marks")

import pandas as pd
dataset = pd.DataFrame(list(data.find()))
print(dataset)


df =dataset.drop("_id",axis ="columns")
print(df)


#df after droping id column

    

#importing the dataset

#dataset = pd.read_csv('E:/Student csv file/student_info.csv')

#Discover and visualize the data to gain insights
print(df.describe())
print(df.info())
print(df.mean())

plt.scatter(x=dataset.study_hours, y=dataset.student_marks)
plt.xlabel("Students Study Hours")
plt.ylabel("Students marks")
plt.title("Scatter Plot of Students Study Hours vs Student marks")
plt.show()

#Preparing the data for Machine Learning algorithms
#Data Cleaning
print(df.isnull().sum())

#print(dataset.mean())
# assigning the null values with mean values
df1 = dataset.fillna(dataset.mean())

#after removing _id from df1
df2 =df1.drop("_id",axis ="columns")
print(df2)


#print(df.isnull().sum())

#study_hours ->independent variable
#study_marks ->dependent variable

#Splitting the dataset 
X = df2.drop("student_marks",axis="columns")
Y = df2.drop("study_hours",axis="columns")
print("shape of X =",X.shape)
print("shape of Y =",Y.shape)

from sklearn.model_selection import train_test_split
X_train,X_test,Y_train,Y_test = train_test_split(X,Y, test_size = 0.2,random_state=51)
print("shape of X_train =",X_train.shape)
print("shape of X_test =",X_test.shape)
print("shape of Y_train =",Y_train.shape)
print("shape of Y_test =",Y_test.shape)

#Select the model and train it
#Straight line equation
#y = m * x + c
from sklearn.linear_model import LinearRegression
lr = LinearRegression()

# Fitting Simple Linear Regression to the Traning set
print(lr.fit(X_train,Y_train))
print(lr.coef_)# m value
print(lr.intercept_) # c value


# predicting the test Results
y_pred = lr.predict(X_test)
print(y_pred)

print(pd.DataFrame(np.c_[X_test,Y_test,y_pred],columns =["study_hours","student_marks_original","student_marks_predicted"]))


#Fine-tune our Model
print(lr.score(X_test, Y_test))

#Visualising the Training  set result
# plt.scatter(X_train,Y_train)
# plt.plot(X_train,lr.predict(X_train),color="r")
# plt.xlabel("Students Study Hours")
# plt.ylabel("Students Marks")
# plt.title("Visualising the Training  set result")
# plt.show()


# #Visualising the Test set result
# plt.scatter(X_test,Y_test)
# plt.plot(X_train,lr.predict(X_train),color="r")
# plt.xlabel("Students Study Hours")
# plt.ylabel("Students Marks")
# plt.title("Visualising the Test set result")
# plt.show()

# study_hours=[6.83,6.56,5.67,8.67,7.55]
# #visualization
# index = np.arange(2)
# plt.axis([0,90,-0,5,10,15,20,25])
# plt.title('A Multipled Stacked Bar Chart')
# plt.bar(index,'study_hours',color='r',bottom=series1)
# plt.bar(index,'students_marks',color='b',bottom=series2)
# plt.legend(['study_hours','students_marks'],loc=2)
# plt.show()

#Histogram of study_hours
#plt.hist(df2['study_hours'],width =0.5,bins=5)

#print(df2['study_hours'].unique())

#plt.plot(df2['study_hours'])
#plt.xlim(0,100)
#plt.ylim(0,100)
# plt.hist(df2['study_hours'],width =0.5,bins=5)
# plt.xlabel('Studying Hours')
# plt.ylabel('Count')
# plt.hist(df2['study_hours'],width =0.5,bins=5)
# plt.title('Students Studying Hours')



#graph
# plt.plot(df2['study_hours'],label ='Studying hours of students')
# plt.plot(df2['student_marks'],label ='Students grades',)
# plt.legend(loc=0)
# plt.show()


#other graph
plt.subplot(1,2,1)
plt.plot(df2['study_hours'],color='red')

plt.subplot(1,2,2)
plt.plot(df2['student_marks'],color='blue')
plt.suptitle('Studying hours and Students Marks')
plt.show()

