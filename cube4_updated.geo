SetFactory("OpenCASCADE");

// ========== Global Parameters ==========
unit = 4;

l = unit;
s = unit/4;

Box(1) = {-l/2, -s/2, -s/2, l, s, s};
Box(2) = {-s/2, -s/2, -l/2, s, s, l};
Box(3) = {-s/2, -l/2, -s/2, s, l, s};

rad = 1/4 * unit;
Sphere(5) = {0, 0, l/2, rad};

BooleanUnion(6) = { Volume{1,2,3}; Delete; } { Volume{5}; Delete; };

Mesh.CharacteristicLengthFactor = 0.3;

Mesh 3;
