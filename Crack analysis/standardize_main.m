function []=parameterise_cracks(image)

    image = standardize(image);
    image = imbinarize(image);
    
    %remove white areas of less than a number of pixels
    image = bwareaopen(image, 20);

    skeleton = get_skeleton(image);


    % find the branch points
    branch_points = get_branch_points(skeleton);

    branch_points_no = sum(sum(branch_points));
    
    edges = get_junctions(skeleton);
   
    edges = sum(sum(edges));

    nodes = branch_points_no
    vertecies = edges + nodes
end