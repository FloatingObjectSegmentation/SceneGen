% read the point cloud
datafolder = 'scans/scans/Scan';
datasuffix = '00000.pcd';
ptCloud = pcread(join([datafolder, '4', datasuffix]));

% read the ground truth matrices
X = getfield(load('data/4data.mat'), 'data');
y = getfield(load('data/4classes.mat'), 'classes');

ClusterIndices = RBNN(ptCloud.Location, 4.0, 5);

segmentation_plot(ptCloud, ClusterIndices);
hold on;

%% plot the ground truths
dronepos = X(y == 1, :)

for i = 1:1:size(dronepos, 1)    
    centroid = dronepos(i, :);
    cid = segmentation_segsimple(ptCloud.Location, ClusterIndices, centroid);

    % find the centroid of the drone
    dronePts = ptCloud.Location(ClusterIndices == cid, :);
    droneCentroid = mean(dronePts);

    % compute the bounding box
    droneBoundingBox = max(dronePts) - min(dronePts) + [5, 5, 5];

    plotcube(droneBoundingBox, droneCentroid - droneBoundingBox/2, .3, [1 0 1]);
end

% plot sensor origin
plotcube([5,5,5], [-2.5, -2.5, -2.5], .3, [0 1 0]);

%% Get all the drones from the scenes and turn them into descriptors

