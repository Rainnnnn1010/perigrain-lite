SetFactory("OpenCASCADE");

lc        = 0.1;    
r_sphere  = 0.5;    
r_cyl     = 0.15;   // 圆柱半径
h_cyl     = 0.5;    // 圆柱长度
h_insert  = r_cyl;  // 圆柱球体重叠度
height = 0.6;
width = 0.2; 	    //圆柱体半径

Sphere(1) = {0, 0, 0, 0.3, -Pi/2, Pi/2, 2*Pi};

// +X
Cylinder(2) = {0, 0, 0, 2.45, 0, 0, width,2*Pi};
Sphere(3) = {1.5, 0, 0, 2*h_cyl,-Pi/2, Pi/2, 2*Pi};
Sphere(4) = {1.5, 0, 0, 2*h_cyl-0.2,-Pi/2, Pi/2, 2*Pi};
Box(996) = {0.5, -1, -1, 1.6, 2.2, 2};

shell5 = BooleanDifference{ Volume{3}; Delete; }{Volume{4}; Delete;};
shell888 = BooleanDifference{ Volume{shell5}; Delete; }{Volume{996}; Delete;};

//BooleanUnion(888) = { Volume{2}; Delete; } {Volume{1}; Delete; };
//BooleanUnion(887) = { Volume{shell5_cut}; Delete; } {Volume{1}; Delete; };

// -X
Cylinder(5) = {0, 0, 0, -2.45, 0, 0, width,2*Pi};
Sphere(6) = {-1.5, 0, 0, 2*h_cyl,-Pi/2, Pi/2, 2*Pi};
Sphere(7) = {-1.5, 0, 0, 2*h_cyl-0.2,-Pi/2, Pi/2, 2*Pi};
Box(995) = {-0.5, -1, -1, -1.6, 2.2, 2};

shell6 = BooleanDifference{ Volume{6}; Delete; }{Volume{7}; Delete;};
shell6_cut = BooleanDifference{ Volume{shell6}; Delete; }{Volume{995}; Delete;};

BooleanUnion(887) = { Volume{5}; Delete; } {Volume{shell6_cut}; Delete; };
BooleanUnion(886) = { Volume{1}; Delete; } {Volume{887}; Delete; };
BooleanUnion(888) = { Volume{2}; Delete; } {Volume{886}; Delete; };


// +Y
Cylinder(9) = {0, 0, 0, 0, 2.3, 0, width,2*Pi};
Sphere(10)  = {0, 1.5, 0, 2*h_cyl,-Pi/2, Pi/2, Pi};
Sphere(11) = {0, 1.5, 0, 2*h_cyl-0.2, -Pi/2, Pi/2, Pi};
Box(999) = {-1, 1, -1, 2, 1.1, 2};

shell1 = BooleanDifference{ Volume{10}; Delete; }{Volume{11}; Delete;};
shell1_cut = BooleanDifference{ Volume{shell1}; Delete; }{Volume{999}; Delete;};


BooleanUnion(885) = { Volume{9}; Delete; } {Volume{888}; Delete; };

// -Y
Cylinder(13) = {0, 0, 0, 0, -2.4, 0, width,2*Pi};
Sphere(14)   = {0, -1.5, 0, 2*h_cyl, -Pi/2, Pi/2, 2*Pi};
Sphere(15) = {0, -1.5, 0, 2*h_cyl-0.2, -Pi/2, Pi/2, 2*Pi};
Box(998) = {-1, -2, -1, 2, 1.6, 2};

shell2 = BooleanDifference{ Volume{14}; Delete; }{Volume{15}; Delete;};
shell2_cut = BooleanDifference{ Volume{shell2}; Delete; }{Volume{998}; Delete;};

// +Z
Cylinder(17) = {0, 0, 0, 0, 0, 2.4, width,2*Pi};
Sphere(18)   = {0, 0, 2*r_sphere + h_cyl, 2*h_cyl, Pi/6, Pi/2, 2*Pi};
Sphere(19)   = {0, 0, 2*r_sphere + h_cyl, 2*h_cyl-0.2, Pi/6, Pi/2, 2*Pi};

shell3 = BooleanDifference{ Volume{18}; Delete; }{Volume{19}; Delete;};

// -Z
Cylinder(21) = {0, 0, 0, 0, 0, -2.4, width,2*Pi};
Sphere(22)   = {0, 0, -2*r_sphere - h_cyl, 2*h_cyl, -Pi/2 , -Pi/6, 2*Pi};
Sphere(23)   = {0, 0, -2*r_sphere - h_cyl, 2*h_cyl-0.2, -Pi/2, -Pi/6, 2*Pi};

shell4 = BooleanDifference{ Volume{22}; Delete; }{Volume{23}; Delete;};



Mesh.CharacteristicLengthMin = 0.1;
Mesh.CharacteristicLengthMax = 0.2;
Mesh 3;//+
