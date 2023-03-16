function ratio = get_isoperimetric_ratio(C )
    %Compute the average area and perimeter of the polygons
    areas = zeros(num_polygons,1);
    perimeters = zeros(num_polygons,1);
    for i = 1:num_polygons
        % Get the indices of the vertices of the polygon
        vertex_indices = C{i};
        % Compute the area and perimeter of the polygon
        x = V(vertex_indices,1);
        y = V(vertex_indices,2);
        areas(i) = polyarea(x,y);
        perimeters(i) = sum(sqrt(diff(x).^2 + diff(y).^2)) + sqrt((x(1)-x(end)).^2 + (y(1)-y(end)).^2);
    end
    
    isoperimetric_ratio = 4*pi*areas / perimeters.^2;

    ratio = mean(isoperimetric_ratio);