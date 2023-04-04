function [] = tif_to_jpeg()

paths = ['data 1/unsaturated/'];


    path = paths;
    image_files = dir(path);
    file_names = image_files;
    file_names(1) = [];
    file_names(1) = [];

    for index = 1:length(file_names)
        file = file_names(index).name;
        if file ~= "jpgs"
            file_location = append(path, file);
    
            img = imread(file_location);
    
            file_no_ext = extractBefore(file, ".");
            file = append(file_no_ext, '.jpg');
    
            imwrite(img, append('data 1/unsaturated/jpgs/', file));
        end
    end
end




