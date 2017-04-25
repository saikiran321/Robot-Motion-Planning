
figure(2);

% You should experiment by changing these coordinates
start_coords = [40, 80];
dest_coords = [100, 110];

input_map=cspace;
cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0];

colormap(cmap);


[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distances = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

parent(start_node)=-2;
distances(start_node) = 0;

% Main Loop
kk=1;
while true
    kk=kk+1;
    
    %pause
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    if (true)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    % Update map
    % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distances), current);
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
   
    %%% All of your code should be between the two lines of stars. 
    % *******************************************************************
       
        
        
        nei=[];
    n1=[i-1,j];
    n2=[i+1,j];
    n3=[i,j+1];
    n4=[i,j-1];
    if n1(1)>0 & input_map(n1(1),n1(2))~=1
        nei=[nei sub2ind(size(map),n1(1),n1(2))];
    end
    if n4(2)>0 & input_map(n4(1),n4(2))~=1
        nei=[nei sub2ind(size(map),n4(1),n4(2))];
    end
    if n2(1)<nrows+1 & input_map(n2(1),n2(2))~=1
        nei=[nei sub2ind(size(map),n2(1),n2(2))];
    end
    if n3(2)<ncols+1 &  input_map(n3(1),n3(2))~=1
        nei=[nei sub2ind(size(map),n3(1),n3(2))];
    end
    for i=nei
        
        if(parent(i)==0)
        map(i)=4;
        distances(i)=distances(current)+1;
        parent(i)=current;
        end
    end
    distances(current) = Inf;
    map(current)=3;
    
    % *******************************************************************
end

if (isinf(distances(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= -2)
        route = [parent(route(1)), route];
    end
    
end
