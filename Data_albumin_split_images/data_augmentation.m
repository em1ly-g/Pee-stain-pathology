function []=data_augmentation()
    folders = {'OA/', 'OB/', 'OC/', 'OD/', 'OE/', 'OF/'};

    for index = 1:length(folders)
        path = folders{index};
        filelist = dir(path);
        for i = 1:numel(filelist)
            file_name = filelist(i).name;
            if ~strcmp(file_name,'.') && ~strcmp(file_name,'..') % exclude '.' and '..' directories
                
                file_name = erase(file_name, '.jpg');
                file_type = '.jpg';
                file = append(path, file_name, file_type);

                img = process(file);

                [width, height] = size(img);
    
                % make flipped versions of the images
                img_vertical_flip = flipdim(img, 1);
                img_horizontal_flip = flipdim(img, 2);
                img_both_flip = flipdim(img_vertical_flip, 2);

    
    
                % add zooming transformations
                img_zoom = imresize(img, 1.2);
                [zoom_width, zoom_height] = size(img_zoom);
                img_zoom1 = imcrop(img_zoom, [1, 1, height-1, width-1]);
                img_zoom2 = imcrop(img_zoom, [zoom_height - height, zoom_width - width, ...
                                    height, width]);

                img_zoom_out = imresize(img, 0.95);
                [zoom_out_height, zoom_out_width] = size(img_zoom_out);
                borderx = floor(height - zoom_out_height) / 2;
                bordery = floor(width - zoom_out_width) / 2;
                img_zoom_out1 = padarray(img_zoom_out, [6, 7], 0, 'both');        
    
                % add a rotation
                img_turn1 = imrotate(img, 10, 'crop');
                img_turn2 = imrotate(img, -10, 'crop');
    
                % show figues
    %figure
    %imshow(img_vertical_flip)
    %figure
    %imshow(img_horizontal_flip)
    %figure
    %imshow(img_both_flip)
    %figure
    %imshow(img_zoom)
    %figure
    %imshow(img_zoom1)
    %figure
    %imshow(img_zoom2)
    %figure
    %imshow(img_zoom_out1)
    %figure
    %imshow(img_turn1)
    %figure
    %imshow(img_turn2)

                % write images
                location = append('Augmented/', path, file_name);
                imwrite(img, append(location, '.jpg'));
                imwrite(img_vertical_flip, append(location, 'vert_flip', '.jpg'));
                imwrite(img_horizontal_flip, append(location, 'hor_flip', '.jpg'));
                imwrite(img_both_flip, append(location, 'double_flip', '.jpg'));
                imwrite(img_zoom1, append(location, 'zoom1', '.jpg'));
                imwrite(img_zoom2, append(location, 'zoom2', '.jpg'));
                imwrite(img_zoom_out1, append(location, 'zoom_out', '.jpg'));
                imwrite(img_turn1, append(location, 'rot1', '.jpg'));
                imwrite(img_turn2, append(location, 'rot2', '.jpg'));

            end
        end
    end
end