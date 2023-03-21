function []=main()
    addpath('skeletonization\')

    path = '..\\data2-albumin/All images/';
    image_files = dir(path);
    file_names = image_files;
    % the first two lines in the struct are '.' and '..'
    file_names(1) = [];
    file_names(1) = [];
    %file = fopen('nodes.txt', 'w');
    %for index = 1:length(file_names)
        image_name = file_names(40).name;
        image_name = append(path, image_name);

        image = imread(image_name);

        skeleton = get_skeleton(image);

        nodes = parameterise_cracks(image);

        polygons = get_polygons(skeleton);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% some reason there is only 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% polygon :(
        % Loop over each polygon
        figure
    for i = 1:length(polygons)
        % Display the i-th polygon
        imshow(polygons{i});

        % Add a title to the figure
        title(sprintf('Polygon %d', i));
        pause(3);
  
    end

        % write into txt file
        
        %fprintf(file, '%d\n', node);
    %end
    %fclose(file);

end