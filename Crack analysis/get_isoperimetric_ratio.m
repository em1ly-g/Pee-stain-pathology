function ratio = get_isoperimetric_ratio(V, C)
    num_polygons = length(C);
    %Compute the average area and perimeter of the polygons
    areas = [];
    perimeters = [];
    for i = 1:num_polygons
        % Get the indices of the vertices of the polygon
        vertex_indices = C{i};
        % Compute the area and perimeter of the polygon
        x = V(vertex_indices,1);
        y = V(vertex_indices,2);
        area = polyarea(x,y);
        perimeter = sum(sqrt(diff(x).^2 + diff(y).^2)) + sqrt((x(1)-x(end)).^2 + (y(1)-y(end)).^2);
        if (~ isnan(area))
            areas = [areas, area];
            perimeters = [perimeters, perimeter];
        end
    end

    perimeters_sqr = perimeters.^2;
    
    isoperimetric_ratio = 4*pi*areas ./ perimeters_sqr;

    ratio = mean(isoperimetric_ratio);