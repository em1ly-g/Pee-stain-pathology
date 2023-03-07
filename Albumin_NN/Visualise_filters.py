# -*- coding: utf-8 -*-
"""
Created on Mon Mar  6 16:17:21 2023

@author: joefi
"""

import os
import cv2
import imghdr
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
import tensorflow_io as tfio
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Dense, Flatten, Dropout
from tensorflow.keras.metrics import Precision, Recall, BinaryAccuracy
from tensorflow.keras.models import load_model
from keras.models import Model


#load model
model = load_model(os.path.join('models','imageclassifier_NN1.h5'))




#-------playing around with displaying--------

#                              |
#using this index              |
#pull out layers of choice     v
layer = model.layers
filters, biases = model.layers[4].get_weights()
#check layers correctly pulled out
print(layer[4].name,filters.shape)
#--------------------------------------------#



#---------------plotting filters---------------------#



#col * rows = number of filters in conv layer
#given by last number in model summary 
#use summary to find indices and size of conv layers, or remember from build
#conv_layer_index = [0, 2, 4] for the first NN
conv_layer_index = [0, 2, 4]  #TO define a shorter model
conv_layer_sizes = [16,32,16] #must match in order of index

j=0
while j<=len(conv_layer_index)-1:
    
    filters, biases = model.layers[int(conv_layer_index[j])].get_weights()
    
    filter_num = conv_layer_sizes[j]
    if filter_num%4==0:
        columns = int(filter_num/4)
        rows = 4
    elif filter_num%2==0:
        columns = int(filter_num/2)
        rows = 2
    else:
        columns = filter_num
        rows = 1
    
    
    fig=plt.figure(figsize=(12, 12))
    for i in range(1, columns*rows +1):
        f = filters[:, :, :, i-1]
        fig =plt.subplot(rows, columns, i)
        fig.set_xticks([])  #Turn off axis
        fig.set_yticks([])
        plt.imshow(f[:, :, 0], cmap='gray')
        #pos += 1
    j=j+1
    plt.show()
    
#-----------------------------------------------------#


#----plotting activation of filters----#

#Define a new truncated model to only include the conv layers of interest
#use summary to find indices of conv layers
#conv_layer_index = [0, 2, 4]
conv_layer_index = [0, 2, 4]  #TO define a shorter model
conv_layer_sizes = [16,32,16] #must match in order of index
outputs = [model.layers[i].output for i in conv_layer_index]
model_short = Model(inputs=model.inputs, outputs=outputs)
print(model_short.summary())

#Input shape to the model is 256 x 256,  so resize input image to this shape.
from tensorflow.keras.utils import load_img, img_to_array
img = load_img('Filter_test_OD.png', target_size=(256, 256)) #VGG user 256 as input

# convert the image to an array to feed into NN
img = img_to_array(img)
# expand dimensions to match the shape of model input
img = np.expand_dims(img, axis=0)

# Generate feature output by predicting on the input image
feature_output = model_short.predict(img)



j=0
while j<=len(feature_output)-1:
    ftr = feature_output[j]
    
    filter_num = conv_layer_sizes[j]
    if filter_num%4==0:
        columns = int(filter_num/4)
        rows = 4
    elif filter_num%2==0:
        columns = int(filter_num/2)
        rows = 2
    else:
        columns = filter_num
        rows = 1
    
    
    fig=plt.figure(figsize=(12, 12))
    for i in range(1, columns*rows +1):
        fig =plt.subplot(rows, columns, i)
        fig.set_xticks([])  #Turn off axis
        fig.set_yticks([])
        plt.imshow(ftr[0, :, :, i-1], cmap='gray')
        #pos += 1
    j=j+1
    plt.show()
    
    
