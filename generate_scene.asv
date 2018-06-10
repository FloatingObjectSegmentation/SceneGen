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
droneMinX = -100;
droneMaxX = 100;
droneMinY = -100;
droneMaxY = 100;
droneMinZ = 0;
droneMaxZ = 50;

treeMinX = droneMinX;
treeMaxX = droneMaxX;
treeMinY = droneMinY;
treeMaxY = droneMaxY;
treeMinZ = -15;
treeMaxZ = -15;

otherMinX = droneMinX;
otherMaxX = droneMaxX;
otherMinY = droneMinY;
otherMaxY = droneMaxY;
otherMinZ = 0;
otherMaxZ = 0;

% radius of each object (in Blender world space)
droneRadius = 3;
treeRadius = 30; % must be centered at base + (0,0,30) => this is the center of the tree
otherRadius = 8;


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
                treeMinX, treeMaxX,...
                treeMinY, treeMaxY,...
                treeMinZ, treeMaxZ);   
otherLocs = createRandom3DPointMatrixBounded(numOther,...
                otherMinX, otherMaxX,...
                otherMinY, otherMaxY,...
                otherMinZ, otherMaxZ);  
                            
% drone orientations
droneOrientations = createRandom3DPointMatrixBounded(numDrones,...
                        0, 0,...
                        0, 0,...
                        0, 360);

 
%% resample the world space for objects that are overlapping other objects
classes = vertcat(ones(numDrones, 1), ones(numTrees, 1) * 2, ones(numOther, 1) * 3);
data = vertcat(droneLocs, treeLocs, otherLocs);
radii = [droneRadius, treeRadius, otherRadius];

% trees have local space origin at the roots, it should be in the center
data(classes == 2, :) = data(classes == 2, :) + repmat([0, 0, 30], sum(classes == 2), 1);

for i = 1:1:size(data, 1)
    while true
        KdTree = createns(data, 'Distance', 'euclidean');
        Cluster = rangesearch(KdTree, data(i, :), radii(classes(i)));
        if max(size(Cluster{1})) == 1
            break
        end
        % resample
        if classes(i) == 1
            data(i,:) = resample(droneMinX, droneMaxX, droneMinY, droneMaxY, droneMinZ, droneMaxZ);
        elseif classes(i) == 2
            data(i,:) = resample(treeMinX, treeMaxX, treeMinY, treeMaxY, treeMinZ, treeMaxZ);
        else
            data(i,:) = resample(otherMinX, otherMaxX, otherMinY, otherMaxY, otherMinZ, otherMaxZ);
        end
    end
end

% reset trees local space to roots
data(classes == 2, :) = data(classes == 2, :) - repmat([0, 0, 30], sum(classes == 2), 1);
                    