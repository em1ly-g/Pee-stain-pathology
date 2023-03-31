function avg_num_sides = get_avg_sides(V, C)
    
try
    num_polygons = length(C);
    % Compute the average number of sides per polygon
    num_sides = 0;
    for i = 1:num_polygons
        num_sides = num_sides + length(C{i});
    end
    avg_num_sides = num_sides / num_polygons;
catch
    avg_num_sides = -1;
end