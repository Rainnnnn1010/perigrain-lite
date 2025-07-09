## See: https://gmsh.info/doc/texinfo/gmsh.html#index-gmsh_002fmodel_002focc_002faddSphere
## for more gmsh commands  and examples with python

# gmsh.model.occ.addPoint(0, 0, 0, meshsize, 1)

meshsize = 1/4
rad = 1
angle = np.pi/2

sphere = gmsh.model.occ.addSphere(0, 0, 0, rad, tag=1)
cylinder = gmsh.model.occ.addCylinder(1, 0, 0, -2, 0, 0, r=1, tag=2, angle=angle)
gmsh.model.occ.cut([(3, 1)], [(3, 2)], 3)

out = gmsh.model.occ.copy([(3, 3)])
# print(out)

gmsh.model.occ.translate(out, 1, 0, 0)

gmsh.model.occ.fuse([(3, 3)], [(3, 4)], tag=5)

gmsh.option.setNumber("Mesh.Algorithm", 6);
gmsh.option.setNumber("Mesh.CharacteristicLengthMin", meshsize);
gmsh.option.setNumber("Mesh.CharacteristicLengthMax", meshsize);
gmsh.option.setNumber("Mesh.CharacteristicLengthFactor", 0.5);
gmsh.option.setNumber("General.Verbosity", 0);

gmsh.model.occ.synchronize() # obligatory before generating the mesh
gmsh.model.mesh.generate(3) # generate a 3D mesh...
gmsh.write(msh_file) # save to file
gmsh.finalize() # close gmsh, as opposed to initialize()
