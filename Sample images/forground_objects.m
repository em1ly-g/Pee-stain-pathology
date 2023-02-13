function image = forground_objects(image)
    se = strel('disk',15);
    
    % isolate the background of the image
    background = imopen(image,se);

    image = image - background;
    
    % Use imadjust to increase the contrast of the processed image I2 by 
    % saturating 1% of the data at both low and high intensities and by 
    % stretching the intensity values to fill the uint8 dynamic range.
    image = imadjust(image);

end