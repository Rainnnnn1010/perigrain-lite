import subprocess
import meshio
import numpy as np


#geo code
gmsh_command = ["gmsh", "test.geo", "-3", "-format", "msh2", "-o", "test.msh"]
subprocess.run(gmsh_command, check=True)

def tetra_volume(p0, p1, p2, p3):
    return abs(np.dot(p1 - p0, np.cross(p2 - p0, p3 - p0))) / 6

mesh = meshio.read("test.msh")
points = mesh.points
tets = mesh.cells_dict.get("tetra")
volume = sum(tetra_volume(points[i[0]], points[i[1]], points[i[2]], points[i[3]]) for i in tets)

print("estimated volume is: %.5f " % volume)
