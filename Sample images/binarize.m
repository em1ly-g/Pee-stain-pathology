function img = binarize(img)
    img = imbinarize(img);
    img = bwareaopen(img,50);
end