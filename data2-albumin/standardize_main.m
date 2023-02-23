function []=standardize_main()
    path = 'All/';
    image_files = dir(path);
    file_names = image_files;
    % the first two lines in the struct are '.' and '..'
    file_names(1) = [];
    file_names(1) = [];

    for index = 1:length(file_names)
        if (file_names(index).name ~= "standardised/")
            image_path = append(path, file_names(index).name);
            image = standardize(image_path);
            imwrite(image, append('standardised/', file_names(index).name))
            index
        end 
    end
end