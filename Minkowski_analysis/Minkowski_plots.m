function [Area,Perimeter,Euler] = Minkowski_plots(img_path)
%MINKOWSKI_PLOTS Summary of this function goes here
%   Detailed explanation goes here
img = imread(img_path);
imgray = im2gray(img);

Area = [];
Perimeter = [];
Euler = [];

i=0;
while i <=256
    bin = imbinarize(imgray,i/256);
    [A,l1] = imArea(bin);
    [P,l2] = imPerimeter(bin);
    [E,l3] = imEuler2d(bin);

    Area(end+1) = A;
    Perimeter(end+1) = P;
    Euler(end+1) = E;

    i=i+1;
end



end

