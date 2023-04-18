function skeleton=get_skeleton(image)

    image = standardize(image);
    figure
    imshow(image)
    image = imbinarize(image);
    figure
    imshow(image)
    
    %remove white areas of less than a number of pixels
    image = bwareaopen(image, 20);

    skeleton = Skeleton3D(image);

    figure
    imshow(skeleton)
