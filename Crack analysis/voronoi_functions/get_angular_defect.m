function avg_defect = get_angular_defect(points,C,DT)
% Compute the angular defect of each polygon
    defects = zeros(num_polygons,1);
    for i = 1:num_polygons
        % Get the indices of the vertices of the polygon
        vertex_indices = C{i};
        % Compute the interior angles of the polygon
        angles = zeros(length(vertex_indices),1);
        for j = 1:length(vertex_indices)
            % Get the indices of the points that form the Delaunay triangle
            tri_indices = DT(vertex_indices(j),:);
            % Compute the three vertices of the triangle
            tri_vertices = points(tri_indices,:);
            % Compute the angle opposite the current vertex
            a = tri_vertices(2,:) - tri_vertices(1,:);
            b = tri_vertices(3,:) - tri_vertices(1,:);
            angles(j) = acos(dot(a,b) / norm(a) / norm(b));
        end
        % Compute the angular defect of the polygon
        defects(i) = (2*pi - sum(angles)) / length(vertex_indices);
    end
    avg_defect = mean(defects);
end