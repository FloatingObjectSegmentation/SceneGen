# SceneGen

This project is set up to hold configurations of simulated training and test data
for any project related to the masters' thesis.

## Usage

- First pick the objects you want to use within blender and for each object:
    - determine its scale (has to be constant)
    - determine the scope of its location ([minx, maxy], [miny, maxy], [minz, maxz])
    - determine the radius of the minimal sphere that acts as a convex hull to the object
        - do this approximately - this is used to resample overlapping objects 

- Fill out the configuration section in ```generate_scene.m``` with the above data.

- run it and export the ```data``` and ```classes``` matrices.

Currently works only for the objects: Drone, Tree and Other(Cube, Torus, Cone)