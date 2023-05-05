function skeleton=get_skeleton(image, show)

    image = standardize(image);
    if show
        figure
        imshow(image)
    end
    image = imbinarize(image);
    if show
        figure
        imshow(image)
    end

    %remove white areas of less than a number of pixels
    image = bwareaopen(image, 20);

    skeleton = Skeleton3D(image);
    if show
        figure
        imshow(skeleton)
    end