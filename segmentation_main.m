%% read the point cloud
datafolder = 'scans/scans/Scan';
datasuffix = '00000.pcd';

%% Get all the drones from the scenes and turn them into descriptors
dronedescriptors = cell(50, 1);
currcell = 1;
for scene = 1:1:20
    
    % get current scene, ground truths
    ptCloud = pcread('testdata/neuronal_training_set/Scan12290045774300000.pcd');
    X = getfield(load(join(["data/", string(scene), "data.mat"], '')), 'data');
    y = getfield(load(join(["data/", string(scene), "classes.mat"], '')), 'classes');
    ClusterIndices = RBNN(ptCloud.Location, 4.0, 5);
    segmentation_plot(ptCloud, ClusterIndices);
    
    % get all drones in the scene
    dronepos = X(y == 1, :);
    for i = 1:1:size(dronepos, 1) 
        % find the centroid and bounding box of the current drone
        centroid = dronepos(i, :);
        cid = segmentation_segsimple(ptCloud.Location, ClusterIndices, centroid);
        dronePts = ptCloud.Location(ClusterIndices == cid, :);
        
        % continue if the cluster is too small
        if max(size(dronePts)) < 3
            continue;
        end
            
        droneCentroid = mean(dronePts);
        
        % continue if the cluster is too far away (it's not the drone!)
        if norm(droneCentroid - centroid) > 5
            continue;
        end
        
        droneBoundingBox = max(dronePts) - min(dronePts) + [1, 1, 1];
        plotcube(droneBoundingBox, droneCentroid - droneBoundingBox/2, .3, [1 0 1]);
        % compute the descriptor
        sigma = norm(droneCentroid) * 0.001;
        template = points_to_gaussian_field(dronePts, droneCentroid - droneBoundingBox / 2, droneBoundingBox, 30, sigma);
        
        dronedescriptors{currcell} = template;
        currcell = currcell + 1;
    end
end

%% Compare them by bhattacharya similarity
bhattacharya = zeros(currcell, currcell);
for i = 1:1:currcell
    for j = 1:1:currcell
        if i == j || j > i
            continue;
        end
        sim = bhattacharya_matching(dronedescriptors{i}, dronedescriptors{j});
        
        bhattacharya(i,j) = sim;
        j
    end
end
max(max(real(bhattacharya)), max(real(bhattacharya')))

%% Compare them by cross-correlation
correlation_matrix = zeros(currcell, currcell);
for i = 1:1:currcell
    for j = 1:1:currcell
        if i == j || j > i
            continue;
        end
        [ssd, ncc] = template_matching(dronedescriptors{i}, dronedescriptors{j});
        [v,loc] = max(ncc(:));
        [ii,jj,k] = ind2sub(size(ncc),loc);
        
        correlation_matrix(i,j) = v;
        j
    end
end
max(max(real(correlation_matrix)), max(real(correlation_matrix')))