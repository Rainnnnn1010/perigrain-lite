# transfering 3dpacman.geo file in .py using pygmsh


import pygmsh
import numpy as np
import math
import gmsh


R       = 1.0;		# radius
h       = 2;		# height
angle   = np.pi/3;


with pygmsh.occ.Geometry() as geom:
    geom.characteristic_length_max = 0.1
    sphere = geom.add_ball(center = [0, 0, 0], radius = 1)
#classpygmsh.occ.cylinder.Cylinder(x0, axis, radius, angle=6.283)
    cylinder = geom.add_cylinder([-1, 0, 0], [2, 0, 0], 1, angle)

    geom.boolean_difference(sphere, cylinder)
    mesh = geom.generate_mesh()
    gmsh.fltk.run()



'''
Step    = 0.5;
BoxSize = 5;                    // side limit
N       = BoxSize/Step;         // generate time

    for i in range(N):
        for j in range(N):
            for k in range(N):
                if i == j == k == 0:
                    continue
                dx, dy, dz = i * Step, j * Step, k * Step
                pac_copy = geom.copy([basepac])
                geom.translate(pac_copy, [dx, dy, dz])


'''
