% will generate 50 scenes with:
%   rand[1,3] drones
%   rand[5,10] trees
%   rand[5,10] cubes, torus, cones of diff sizes
% where:
%   drone location bounded by ([-10,10],[-10,10],[0, 5])
%   drone orientation bounded by (0, 0, [0, 360])
%   other location bounded by same
%   other orientation is constant
% and ensure:
%   - that there is no overlap between examples

%% config

% how many
minDrones = 1;
maxDrones = 3;
minTrees = 5;
maxTrees = 10;
minOther = 5;
maxOther = 10;

% location, orientation boundary
droneMinX = -10;
droneMaxX = 10;
droneMinY = -10;
droneMaxY = 10;
droneMinZ = 0;
droneMaxZ = 5;

otherMinX = droneMinX;
otherMaxX = droneMaxX;
otherMinY = droneMinY;
otherMaxY = droneMaxY;
otherMinZ = 0;
otherMaxZ = 0;
%% code

% generate how many of each
numDrones = round(rand(1,1) * (maxDrones - minDrones)) + minDrones;
numTrees = round(rand(1,1) * (maxTrees - minTrees)) + minTrees;
numOther = round(rand(1,1) * (maxOther - minOther)) + minOther;

% drone locations
droneLocs = createRandom3DPointMatrixBounded(numDrones,...
                droneMinX, droneMaxX,...
                droneMinY, droneMaxY,...
                droneMinZ, droneMaxZ);
treeLocs = createRandom3DPointMatrixBounded(numTrees,...
                otherMinX, otherMaxX,...
                otherMinY, otherMaxY,...
                otherMinZ, otherMaxZ);   
otherLocs = createRandom3DPointMatrixBounded(numOther,...
                otherMinX, otherMaxX,...
                otherMinY, otherMaxY,...
                otherMinZ, otherMaxZ);  
                            
% drone orientations
droneOrientations = createRandom3DPointMatrixBounded(numDrones,...
                        0, 0,...
                        0, 0,...
                        0, 360);
