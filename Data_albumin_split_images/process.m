function img=process(file_path)
    img = imread(file_path);

    [counts, bin_locations] = imhist(img);

    max_intensity = max(counts);
    max_intensity_location = find(counts == max_intensity);
    
    % check if the intensity is greater in the dark or light intensity
    indicies = find(counts < 1000);
    dark_indicies = indicies(find(indicies < max_intensity_location));
    light_indicies = indicies(find(indicies > max_intensity_location));
    total_dark = mean(counts(dark_indicies));
    total_light = mean(counts(light_indicies));
    
    % label the image if the details are in black (dark) or white (light)
    if (total_dark < total_light)
        image_type = "light";
    else
        image_type = "dark";
    end


    if (image_type == "light")
        [x, y] = find(img < max_intensity_location + 15);
        % make background black then invert the image
        for element = 1:length(x)
            xindex = x(element);
            yindex = y(element);
            img(xindex, yindex) = 0;
        end     
        

    elseif (image_type == "dark")
        % make backgrund white
            [x, y] = find(img > max_intensity_location - 40);
            for element = 1:length(x)
                xindex = x(element);
                yindex = y(element);
                img(xindex, yindex) = 255;
            end
            img = imcomplement(img);
    end 
end