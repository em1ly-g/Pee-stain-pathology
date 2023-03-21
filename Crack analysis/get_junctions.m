function junctions = get_junctions(skeleton)

% Define the size of the delta neighborhood
delta = 1;

% Create a matrix to store the junction points
junctions = zeros(size(skeleton));

% Loop through each pixel in the skeleton
for i = 1:size(skeleton, 1)
    for j = 1:size(skeleton, 2)
        % Check if the current pixel is white
        if skeleton(i,j) == 1
            % Define the delta neighborhood around the current pixel
            delta_neighborhood = skeleton(max(1,i-delta):min(size(skeleton,1),i+delta),...
                max(1,j-delta):min(size(skeleton,2),j+delta));
            % Count the number of white pixels in the delta neighborhood
            num_white_pixels = sum(delta_neighborhood(:) == 1);
            % If there are more than two white pixels, mark the current pixel as a junction
            if num_white_pixels > 2
                junctions(i,j) = 1;
            end
        end
    end
end
details = imfuse(skeleton, junctions, 'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);

%figure
%imshow(details)
end