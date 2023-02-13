function image = get_image(image_name, crop)
    
    % get the image
    image_rgb = imread(image_name);
    image_grey = rgb2gray(image_rgb);
    
    % crop the image to size
    if crop
        target_size = [2000, 2000];
        rectangle = centerCropWindow2d(size(image_grey), target_size);
        image = imcrop(image_grey, rectangle);
    else 
        image = image_grey;

    end

