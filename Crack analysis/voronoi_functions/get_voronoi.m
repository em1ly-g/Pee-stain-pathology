function [num_polygons, number_of_sides, angular_defect, ...
                iscoperimetric_ratio, num_nodes, num_vertices]=get_voronoi(image, show)
    try
    
        verticies = get_branch_points(image);
        [x, y] = find(verticies);
        
        [vx, vy] = voronoi(x, y);
        if show
            figure
            plot(vx, vy, 'b')
            axis equal;
        end
    
        % Compute the Voronoi diagram
        points = [x,y];
        [V,C] = voronoin(points);
        DT = delaunay(points);
    
        % Extract the number of polygons
        num_polygons = length(C);
        number_of_sides = get_avg_sides(V, C);
        angular_defect = get_angular_defect(points, C, DT);
        iscoperimetric_ratio = get_isoperimetric_ratio(V, C);
    
        % Compute the number of nodes and vertices
        num_nodes = length(V);
        num_vertices = 0;
        for i = 1:num_polygons
            num_vertices = num_vertices + length(C{i});
        end
        
        % Display the results
        %disp(['Number of polygons: ' num2str(num_polygons)]);
        %disp(['Average number of sides per polygon: ' num2str(number_of_sides)]);
        %disp(['Average angular defect: ' num2str(angular_defect)]);
        %disp(['Average iscoperimetric ratio: ' num2str(iscoperimetric_ratio)]);
        %disp(['Number of nodes: ' num2str(num_nodes)]);
        %disp(['Number of verticies: ' num2str(num_vertices)]);
    catch
        num_polygons = -1;
        number_of_sides = -1;
        angular_defect = -1;
        iscoperimetric_ratio = -1;
        num_nodes = -1;
        num_vertices = -1;
    end

end