# -*- coding: utf-8 -*-
"""
Created on Wed Mar  8 10:06:33 2023

@author: joefi
"""
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
import pandas as pd
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Input, Dense, Dropout
from tensorflow.keras.metrics import Precision, Recall, BinaryAccuracy
import os

def mink_extract(file_path):
    data = np.genfromtxt(file_path,delimiter=',')
    area = data[1:,0]
    perimeter = data[1:,1]
    euler = data[1:,2]
    
    A_norm = area/max(abs(area))
    P_norm = perimeter/max(abs(perimeter))
    E_norm = euler/max(abs(euler))
    
    mink = np.hstack((A_norm,P_norm,E_norm))
    
    return mink

prefixes = np.array(["A","C","E","G","H","I","J","K"])

file_names = np.array([])

for pref in prefixes:
    for num in np.linspace(1,9,9):
        name = pref+"_"+str(int(num))+"_mink.txt"
        file_names = np.append(file_names,name)


data = []
#label 0 if low conc (OA OB OC) 1 if high conc (OD OE OF)
labels = np.array([])

for file in file_names:
    path = "CaOx_Raw_Data/"+file
    try:
        temp_data = mink_extract(path)
        
        data.append(temp_data)
        
        if file[0]=="A" or file[0]=="C" or file[0]=="E" or file[0]=="G":
            labels = np.append(labels,0)
        
        elif file[0]=="H" or file[0]=="I" or file[0]=="J" or file[0]=="K":
            labels = np.append(labels,1)
    except:
        continue

data_array = np.array(data)




#plotting mink curves in blue for low conc and red for high conc
i=0
while i<len(labels):
    if labels[i]==0:
        plt.plot(data[i],'b')
        i=i+1
    elif labels[i]==1:
        plt.plot(data[i],'r')
        i=i+1

############################# NN ###########################################
#putting data into tf format for NN
data_set = tf.data.Dataset.from_tensor_slices((data,labels))  
data_set =  data_set.shuffle(7).batch(5)
data_iterator = data_set.as_numpy_iterator()
batch = data_iterator.next() 

#-------split data------
train_size = int(len(data_set)*.7)
val_size = int(len(data_set)*.2)
test_size = int(len(data_set)*0.1)

train = data_set.take(train_size)
val = data_set.skip(train_size).take(val_size)
test = data_set.skip(train_size+val_size).take(test_size)

#Build NN

model = Sequential()
model.add(Dense(771,activation='relu'))
model.add(Dense(256, activation='relu'))
model.add(Dense(128, activation='relu'))
model.add(Dense(64, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1, activation='sigmoid'))

model.compile('adam', loss=tf.losses.BinaryCrossentropy(), metrics=['accuracy'])

#Train

logdir='logs'
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=logdir)
hist = model.fit(train, epochs=10, validation_data=val, callbacks=[tensorboard_callback])

#Plot Performance

fig = plt.figure()
plt.plot(hist.history['loss'], color='teal', label='loss')
plt.plot(hist.history['val_loss'], color='orange', label='val_loss')
fig.suptitle('Loss', fontsize=20)
plt.legend(loc="upper left")
plt.show()

fig = plt.figure()
plt.plot(hist.history['accuracy'], color='teal', label='accuracy')
plt.plot(hist.history['val_accuracy'], color='orange', label='val_accuracy')
fig.suptitle('Accuracy', fontsize=20)
plt.legend(loc="upper left")
plt.show()

#Evaluate
pre = Precision()
re = Recall()
acc = BinaryAccuracy()
for batch in test.as_numpy_iterator(): 
    X, y = batch
    yhat = model.predict(X)
    pre.update_state(y, yhat)
    re.update_state(y, yhat)
    acc.update_state(y, yhat)
print(pre.result(), re.result(), acc.result())

#save model
model.save(os.path.join('models','CaOx_Mink_classifier1.h5'))
