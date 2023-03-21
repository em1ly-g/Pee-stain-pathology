function polygons = get_polygons()

    addpath('skeletonization\')
    image = imread('..\\data2-albumin/All images/OF_5_C001H001S0001000001.jpg');
    
    I = get_skeleton(image);
    %% https://uk.mathworks.com/matlabcentral/answers/85422-how-to-convert-binary-image-to-2d-triangulation
    
    % pad image with zeros in order to enable border at image boundaries
    temp = zeros(size(I)+2);
    temp(2:end-1,2:end-1) = I;
    I = temp;
    % Get an isocontour
    [a,b] = find(bwperim(I));
    Vertices = [b,a];
    % Triangulate all pts in the isocontour and check which trias are in/out
    DT = delaunayTriangulation(Vertices);
    fc = DT.incenter;
    in = interp2(I, fc(:,1), fc(:,2))==1;
    % Show the result
    figure,imagesc(I), hold on,
    patch('vertices',DT.Points,'faces',DT.ConnectivityList(in,:),'FaceColor','g')
    patch('vertices',DT.Points,'faces',DT.ConnectivityList(~in,:),'FaceColor','c')
    plot(fc(in,1),fc(in,2),'b.', fc(~in,1),fc(~in,2),'y.')
    
end
