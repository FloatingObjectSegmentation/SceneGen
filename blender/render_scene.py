import numpy as np
import bpy
from bpy import data as D
from bpy import context as C
from mathutils import *
from math import *
import blensor
import random

scene_savefolder = '/home/km/Desktop/SceneGen/scans'
basefolder = '/home/km/Desktop/SceneGen/data'

scn = bpy.context.scene

scanner = bpy.data.objects["Camera"]
drone = bpy.data.objects['done_body']
tree = bpy.data.objects['Tree']
cube = bpy.data.objects['Cube']
cone = bpy.data.objects['Cone']
cylinder = bpy.data.objects['Cylinder']
torus = bpy.data.objects['Torus']

rndnum_to_object = {0: cube, 1: cone, 2: cylinder, 3: torus}
class_to_object = {1: lambda: drone, 2: lambda: tree, 3: lambda: rndnum_to_object[round(random.random() * 3)]}

def deleteobjects():
    bpy.ops.object.select_all(action='DESELECT')
    search_terms = ['copied']
    containsSearchTerms = lambda x: any([y != -1 for y in [x.find(s) for s in search_terms]])
    candidates = list(filter(lambda x: containsSearchTerms(x), [k for k in bpy.data.objects.keys()]))
    for c in candidates:
        bpy.data.objects[c].select = True
    bpy.ops.object.delete()

def runalg(i):
    file_dat = basefolder + '/' + str(i) + 'data.mat'
    file_cls = basefolder + '/' + str(i) + 'classes.mat'
    X = np.load(file_dat)
    y = np.load(file_cls)
    genscene(X,y)

def genscene(X,y):
    for j in range(X.shape[0]):
        src_obj = class_to_object[int(y[j])]()
        new_obj = src_obj.copy()
        new_obj.data = src_obj.data.copy()
        new_obj.animation_data_clear()
        scn.objects.link(new_obj)
        new_obj.location = X[j]
        new_obj.name = 'copied' + str(j)
        #if y[j] == 1:
        #    new_obj.rotation_euler = Euler((0,0,random().random() * 360))
            
for i in range(1,2):
    runalg(i)
    savefile = scene_savefolder + "/Scan" + str(i) + ".pcd"
    print(savefile)
    blensor.blendodyne.scan_advanced(scanner, rotation_speed = 10.0, 
                               simulation_fps=24, angle_resolution = 0.1728, 
                               max_distance = 120, evd_file= savefile,
                               noise_mu=0.0, noise_sigma=0.3, start_angle = 0.0, 
                               end_angle = 360.0, evd_last_scan=True, 
                               add_blender_mesh = False, 
                               add_noisy_blender_mesh = False,
                               frame_time = (1.0 / 24.0),
                               simulation_time = 100.0,
                               world_transformation=scanner.matrix_world)
    deleteobjects()
