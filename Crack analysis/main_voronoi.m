function [] = main_voronoi()
    addpath('skeletonization\')
    addpath('voronoi_functions\')

    path = '..\\data2-albumin/All images/';
    image_files = dir(path);
    file_names = image_files;
    % the first two lines in the struct are '.' and '..'
    file_names(1) = [];
    file_names(1) = [];
    file = fopen('voronoi_params2.txt', 'w');
    fprintf(file, 'file, node, defect, ratio, # of sides\n');
    %
    % These files have been edited to show all the images in separate
    % figures. I dont reccomend that you run this iterating over all the
    % images. I used image 8 for the first image in B or 36 for the first
    % image in F

    show = false;

    for index = 1:length(file_names) %replace this with a number to not iterate

        image_name = file_names(index).name;
        image_name = append(path, image_name);

        image = imread(image_name);

        skeleton = get_skeleton(image, show);

        [num_polygons, number_of_sides, angular_defect, ...
                iscoperimetric_ratio, nodes, verticies] = get_voronoi(skeleton, show);
    
        fprintf(file, file_names(index).name);
        fprintf(file, ', %d, ', nodes);
        %fprintf(file, '%d, ', verticies);
        fprintf(file, '%d, ', angular_defect);
        fprintf(file, '%d, ', iscoperimetric_ratio);
        %fprintf(file, '%d, ', num_polygons);
        fprintf(file, '%d \n', number_of_sides);

        %disp('Next image');

    end

        % write into txt file
        
    fclose(file);

end