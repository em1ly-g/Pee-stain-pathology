function branch_points = get_branch_points(image)
    
    % find the branch points
    branch_points = bwmorph(image, 'branchpoints');

    details = imfuse(image, branch_points, 'falsecolor','Scaling','joint','ColorChannels',[2 1 1]);
    
    %figure
    %imshow(details)


