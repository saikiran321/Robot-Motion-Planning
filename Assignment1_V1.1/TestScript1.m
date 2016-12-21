%
% TestScript for Assignment 1
%
close all
clear all

%% Define a small map
map = false(10);

% Add an obstacle
map (1:5, 6) = true;
map (6, 4:9) = true;

start_coords = [6, 2];
dest_coords  = [1, 9];

%%
close all;
[route1, numExpanded] = DijkstraGrid (map, start_coords, dest_coords);
route1
% Uncomment following line to run Astar
[route2, numExpanded] = AStarGrid (map, start_coords, dest_coords);
route2
%HINT: With default start and destination coordinates defined above, numExpanded for Dijkstras should be 76, numExpanded for Astar should be 23.
