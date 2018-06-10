function matrix = createRandom3DPointMatrixBounded(numPoints, xmin, xmax, ymin, ymax, zmin, zmax)
% Creates an uniformly distributed matrix of points with the preferred
% boundaries.
%
% It will also create this in a way that the objects within the scene will
% not overlap eachother

% drone locations
matrix = horzcat(ones(numPoints, 1) * (xmax - xmin), ...
                    ones(numPoints, 1) * (ymax - ymin), ...
                    ones(numPoints, 1) * (zmax - zmin));
matrix = round(rand(numPoints, 3) .* matrix);
matrix = matrix + horzcat(ones(numPoints, 1) * (xmin), ...
                                ones(numPoints, 1) * (ymin), ...
                                ones(numPoints, 1) * (zmin));
end

