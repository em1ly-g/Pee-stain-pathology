function [] = tif_to_jpeg()

paths = ['OF/'];


    path = paths;
    image_files = dir(path);
    file_names = image_files;
    file_names(1) = [];
    file_names(1) = [];

    for index = 1:length(file_names)
        index
        file = file_names(index).name
        
        file_location = append(path, file);

        img = imread(file_location);

        file_no_ext = extractBefore(file, ".")
        file = append(file_no_ext, '.jpg')

        imwrite(img, append('OF_jpeg/', file));
    end
end



