% Step 1: Define the nodes
nodes = 1:10; % Nodes numbered 1 to 10

% Step 2: Define the edges
edges = [1 2; 2 3; 3 4; 4 5; 5 6; 6 7; 7 8; 8 9; 9 10; 10 1; 2 6; 4 8]; 
% Add edges to form a more connected network

% Step 3: Define the nodes' locations
nodeLocations = rand(10, 2) * 10; % Random positions in a 10x10 area for 10 nodes

% Step 4: Create the graph
G = graph(edges(:,1), edges(:,2)); % Create a graph from the edges

% Step 5: Plot the graph
figure;
hold on;

% Plot the graph using node locations
plot(G, 'XData', nodeLocations(:,1), 'YData', nodeLocations(:,2), ...
     'MarkerSize', 7, 'LineWidth', 2, 'NodeColor', 'r', 'EdgeColor', 'b');

% Add labels for the nodes
for i = 1:length(nodes)
    text(nodeLocations(i, 1), nodeLocations(i, 2), num2str(nodes(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'Color', 'k', 'FontSize', 12);
end

% Add title and axis labels
title('Network Topology Visualization (10 Nodes)');
xlabel('X Location');
ylabel('Y Location');

% Set axis limits
xlim([0 10]);
ylim([0 10]);

hold off;
