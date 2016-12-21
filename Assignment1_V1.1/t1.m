map = false(10);

% Add an obstacle
map (1:5, 6) = true;
map(4,4)=true;

start_coords = [6, 2];
dest_coords  = [8, 9];
input_map=map;

% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node.


% set up color map for display
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
while kk<50
    kk=kk+1
    % Draw current map
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
    current;
    min_dist;
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distanceFromStart(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distanceFromStart), current);
    
     parent;
    if current-ncols > 0 & input_map(current-ncols)~=1
        c2=current-ncols;
        map(c2)=3;
        
        if isinf(distanceFromStart(c2)) %& parent(c2) ==1 
             distanceFromStart(c2)=1;
        else
             distanceFromStart(c2)= distanceFromStart(c2)+1;
        end
        parent(c2)=current;
    end
    if current-1 >0 &  input_map(current-1)~=1
        c4=current-1;
        map(c4)=3;
        
        
        if isinf(distanceFromStart(c4)) %& parent(c4) ==0
            distanceFromStart(c4)=1;
        else
             distanceFromStart(c4)= distanceFromStart(c4)+1;
        end
        parent(c4)=current;
    end
    if (current+ncols)<(ncols*nrows) &  input_map(current+ncols)~=1
        c1=current+ncols;
    end
    if current+1<(ncols*nrows) & input_map(current+1)~=1
        c3=current+1;
    end
    parent(c1)=current;
    parent(c3)=current;
    map(c1)=3;
    map(c3)=3;
   
    if isinf(distanceFromStart(c1))
        distanceFromStart(c1)=1;
    else
         distanceFromStart(c1)= distanceFromStart(c1)+1;
    end
    
    
    
    if isinf(distanceFromStart(c3))
        distanceFromStart(c3)=1;
    else
         distanceFromStart(c3)= distanceFromStart(c3)+1;
    end
    
    distanceFromStart;
    
    p=current;
    
    
    
    
   % ********************************************************************* 
    % YOUR CODE BETWEEN THESE LINES OF STARS
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    
    
    
    
    %*********************************************************************

end



%% Construct route from start to dest by following the parent links


if (isinf(distanceFromStart(dest_node)))
    route = [];
else
    
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
    
  
end

