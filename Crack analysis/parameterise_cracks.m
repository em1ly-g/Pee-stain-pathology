function nodes=parameterise_cracks(image)

    skeleton = get_skeleton(image);


    % find the branch points
    branch_points = get_branch_points(skeleton);

    branch_points_no = sum(sum(branch_points));
    
    edges = get_junctions(skeleton);
   
    edges = sum(sum(edges));

    nodes = branch_points;
    vertecies = edges;
end