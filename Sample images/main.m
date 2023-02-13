function [] = main()
    
    image_files = dir('raw_images');
    file_names = image_files;
    % the first two lines in the struct are '.' and '..'
    file_names(1) = [];
    file_names(1) = [];

    path = 'raw_images/';

   
    for index = 1:length(file_names)
        file = file_names(index).name;
        file_location = append(path, file);

        % get greyscale image
        img = get_image(file_location, true);
        
        imshow(img)
        % save the images as greyscale
        imwrite(img, append('greyscale/', file))
        

        % perform forground analysis on the images
        img = forground_objects(img);
        %imshow(img)
        imwrite(img, append('forground/', file))
        

        % binerise the image
        img = binarize(img);
        %imshow(img)
        imwrite(img, append('binary/', file))     
        
    end

end
  
