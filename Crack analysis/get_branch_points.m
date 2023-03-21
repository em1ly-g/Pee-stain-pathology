function branch_points = get_branch_points(image)
    
    % find the branch points
    branch_points = bwmorph(image, 'branchpoints');

    details = imfuse(image, branch_points, 'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    
    %figure
    %imshow(details)


