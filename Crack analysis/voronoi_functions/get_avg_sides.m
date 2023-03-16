function avg_num_sides = get_avg_sides(V, C)
    
    num_polygons = length(C);
    % Compute the average number of sides per polygon
    num_sides = 0;
    for i = 1:num_polygons
        num_sides = num_sides + length(C{i});
    end
    avg_num_sides = num_sides / num_polygons;
end