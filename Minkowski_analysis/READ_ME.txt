Initial push 08/03/23

This folder contains minkowski analysis of avulbumin images including a NN that classifies into "Low" and "high" conc.

series of .m files to process any image to return .txt file with the 3 minkowski functionals 
Area, Perimeter, Euler characterstic

the .txt files as a result of processing all the protein images stored in Raw_Data folder

minkNN.py file which extracts from Raw_Data folder and feeds into NN
NN got accuracy of 1 (V nice) stored in models as .h5 file

it also learned in less than 5 seconds!!! loss and acc plots dont seem to suggest any overfitting but again only got less than 50 data points to train on.


also plots of minkowski functionals for low and high conc, can easily see difference without NN. 