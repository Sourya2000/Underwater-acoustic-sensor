% Parameters
numSensors = 10; % Number of sensors
fieldSize = [100, 100, 50]; % Dimensions of underwater space (X, Y, Z)
commRange = 30; % Communication range in meters

% Randomly initialize sensor positions
sensorPositions = [rand(numSensors, 1) * fieldSize(1), ...
                   rand(numSensors, 1) * fieldSize(2), ...
                   rand(numSensors, 1) * fieldSize(3)];

% Calculate distance matrix
distMatrix = zeros(numSensors, numSensors);
for i = 1:numSensors
    for j = 1:numSensors
        distMatrix(i, j) = norm(sensorPositions(i, :) - sensorPositions(j, :));
    end
end

% Generate connectivity matrix (Adjacency Matrix)
connectivityMatrix = distMatrix <= commRange & distMatrix > 0;

% Visualize sensors and connections
figure;
hold on;
for i = 1:numSensors
    scatter3(sensorPositions(i, 1), sensorPositions(i, 2), sensorPositions(i, 3), 'filled');
    text(sensorPositions(i, 1), sensorPositions(i, 2), sensorPositions(i, 3), sprintf('S%d', i));
end

% Draw connections
for i = 1:numSensors
    for j = i+1:numSensors
        if connectivityMatrix(i, j)
            plot3([sensorPositions(i, 1), sensorPositions(j, 1)], ...
                  [sensorPositions(i, 2), sensorPositions(j, 2)], ...
                  [sensorPositions(i, 3), sensorPositions(j, 3)], 'b');
        end
    end
end
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Underwater Sensor Network Topology');
grid on;
hold off;

% Discover topology using Breadth-First Search (BFS)
visited = false(1, numSensors);
topology = [];
queue = [1]; % Start with sensor 1
while ~isempty(queue)
    current = queue(1);
    queue(1) = [];
    if ~visited(current)
        visited(current) = true;
        topology = [topology, current];
        neighbors = find(connectivityMatrix(current, :));
        for neighbor = neighbors
            if ~visited(neighbor)
                queue = [queue, neighbor];
            end
        end
    end
end

disp('Discovered Topology (Order of visited sensors):');
disp(topology);
