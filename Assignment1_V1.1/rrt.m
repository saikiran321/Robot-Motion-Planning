map = false(10);

% Add an obstacle
map (1:5, 6) = true;
map(4,4)=true;
map(4:8,8)=true;
%map
start_coords = [6, 2];
dest_coords  = [2, 9];
input_map=map;

% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0; ...
	0.5 0.5 0.5];

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distanceFromStart = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distanceFromStart(start_node) = 0;
parent(start_node)=-2;

% keep track of number of nodes expanded 
numExpanded = 0;

% Main Loop
kk=1;
exp=0;
while true
  kk=kk+1;
    map(start_node) = 5;
    map(dest_node) = 6;
    
    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distanceFromStart(:));
   
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    
    map(current) = 3;
    
    % Update map
           % mark current node as visited
     % remove this node from further consideration
  
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current);
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
    if n2(1)<11 & input_map(n2(1),n2(2))~=1
        nei=[nei sub2ind(size(map),n2(1),n2(2))];
    end
    if n3(2)<11 &  input_map(n3(1),n3(2))~=1
        nei=[nei sub2ind(size(map),n3(1),n3(2))];
    end
    for i=nei
        
        if(parent(i)==0)
        map(i)=4;
        distanceFromStart(i)=distanceFromStart(current)+1;
        parent(i)=current;
        end
    end
    distanceFromStart(current) = Inf;
    map(current)=3;
    distanceFromStart;
    parent;
  
    
    
    
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    
    
    
    
    %*********************************************************************

end

%% Construct route from start to dest by following the parent links
numExpanded=sum(map(:)==3)+1;

if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    
    route = [dest_node];
   
    while (parent(route(1)) ~= -2)
        route = [parent(route(1)), route];
    end
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
  
end



