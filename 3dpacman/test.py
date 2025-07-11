import gmsh
import numpy as np

msh_file = "pacman.msh"
gmsh.initialize()

meshsize = 1/4
rad      = 1
angle    = np.pi/2

Step     = 2.2        
BoxSize  = 3           # side limit
N        = int(BoxSize / Step)   # total generate time


RotNum   = 4          # angle of rotation
dPhi     = 2*np.pi / RotNum

# base Pac-Man 
sphere   = gmsh.model.occ.addSphere(0, 0, 0, rad, tag=1)
cylinder = gmsh.model.occ.addCylinder(1, 0, 0, -2, 0, 0,
                                      r=1, tag=2, angle=angle)
gmsh.model.occ.cut([(3, 1)], [(3, 2)], tag=3)  
base_vol = [(3, 3)]                             # basic pac



volumes = []  				        #record all dimTags
for i in range(N + 1):
    for j in range(N + 1):
        for k in range(N + 1):
            dx, dy, dz = i * Step, j * Step, k * Step

               # a) base Pac-Man
            v0 = gmsh.model.occ.copy(base_vol)          # [(3, newTag)]
            gmsh.model.occ.translate(v0, dx, dy, dz)
            volumes.append(v0[0])

            # b) rotate Pac-Man
            for p in range(RotNum):
                phi = p * dPhi
                if phi == 0:          
                    continue
                v = gmsh.model.occ.copy(base_vol)
                gmsh.model.occ.rotate(v, 0, 0, 0, 0, 0, 1, phi)  
                gmsh.model.occ.translate(v, dx, dy, dz)
                volumes.append(v[0])




# ----------------- detect intersections -----------------
gmsh.model.occ.synchronize()                  



to_remove = set()                             # define volume neede remove

for a in range(len(volumes)):
    if a in to_remove:
        continue
    for b in range(a + 1, len(volumes)):
        if b in to_remove:
            continue
       

        
        try:
            frag, _ = gmsh.model.occ.cut([volumes[a]], [volumes[b]],
                                         removeObject=False)
                                
        except Exception:
            frag = []    # non intersect

        # see if there is frag left
        intersect = (not frag) or (len(frag) != 1) or (frag[0][1] != volumes[a][1])

        # delete the frag item
        if frag:
            gmsh.model.occ.remove(frag, recursive=True) # recursive=true: delete all related stuff

        if intersect:
            to_remove.update((a, b))   # remove both a & b

# delete all intersected volume
if to_remove:
    gmsh.model.occ.remove([volumes[i] for i in to_remove], recursive=True)
    gmsh.model.occ.synchronize()


'''
remaining = [volumes[i] for i in range(len(volumes)) if i not in to_remove]

# union

fused,_ = gmsh.model.occ.fuse(remaining, [],
                              removeObject=True, removeTool=True)
gmsh.model.occ.synchronize()
main_vol = fused[0]                      # make it a single shape

#calculate volume
total_vol = gmsh.model.occ.getMass([main_vol])[0]
print(f"Remaining fused volume = {total_vol:.5f} ")

'''



gmsh.option.setNumber("Mesh.Algorithm",               6)
gmsh.option.setNumber("Mesh.CharacteristicLengthMin", meshsize)
gmsh.option.setNumber("Mesh.CharacteristicLengthMax", meshsize)
gmsh.option.setNumber("Mesh.CharacteristicLengthFactor", 0.5)
gmsh.option.setNumber("General.Verbosity",            0)


gmsh.model.occ.synchronize() # obligatory before generating the mesh
gmsh.model.mesh.generate(3) # generate a 3D mesh...

gmsh.fltk.initialize()      
gmsh.fltk.run()
             
gmsh.write(msh_file) # save to file
gmsh.finalize() # close gmsh, as opposed to initialize()
