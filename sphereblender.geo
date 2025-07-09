SetFactory("OpenCASCADE");

lc        = 0.1;    
r_sphere  = 0.5;    
r_cyl     = 0.15;   // 圆柱半径
h_cyl     = 0.5;    // 圆柱长度
h_insert  = r_cyl;  // 圆柱球体重叠度


Sphere(1) = {0, 0, 0, r_sphere};

// +X

Cylinder(2) = {r_sphere - h_insert, 0, 0, 1, 0, 0, r_cyl};
Sphere(3) = {2*r_sphere + h_cyl, 0, 0, 2*h_cyl,-Pi/11, Pi/11, 2*Pi};
Sphere(4) = {2*r_sphere + h_cyl, 0, 0, 2*h_cyl-0.2,-Pi/2, Pi/2, 2*Pi};
Box(996) = {0.5, -1, -0.5, 1.5, 2.2, 1};

shell5 = BooleanDifference{ Volume{3}; Delete; }{Volume{4}; Delete;};
BooleanDifference{ Volume{shell5}; Delete; }{Volume{996}; Delete;};


// -X
Cylinder(5) = {-r_sphere + h_insert, 0, 0, -2*h_cyl - h_insert, 0, 0, r_cyl};
Sphere(6) = {-2*r_sphere - h_cyl, 0, 0, 2*h_cyl,-Pi/11, Pi/11, 2*Pi};
Sphere(7) = {-2*r_sphere - h_cyl, 0, 0, 2*h_cyl-0.2,-Pi/2, Pi/2, 2*Pi};
Box(995) = {-0.5, -1, -0.5, -1.5, 2.2, 1};

shell6 = BooleanDifference{ Volume{6}; Delete; }{Volume{7}; Delete;};
BooleanDifference{ Volume{shell6}; Delete; }{Volume{995}; Delete;};


// +Y
Cylinder(9) = {0, r_sphere - h_insert, 0, 0, 3*h_cyl + h_insert, 0, r_cyl};
Sphere(10)  = {0, r_sphere + h_cyl, 0, 2*h_cyl,-Pi/11, Pi/11, Pi};
Sphere(11) = {0, r_sphere + h_cyl, 0, 2*h_cyl-0.2, -Pi/8, Pi/8, Pi};
Box(999) = {-1, 2*r_sphere, -0.5, 2, 0.6, 1};

shell1 = BooleanDifference{ Volume{10}; Delete; }{Volume{11}; Delete;};
BooleanDifference{ Volume{shell1}; Delete; }{Volume{999}; Delete;};



Rotate {{0, 1, 0}, {0, 0, 0}, Pi/2} {
  Curve{42};
}

// -Y
Cylinder(13) = {0, -r_sphere + h_insert, 0, 0, 2*-h_cyl - 2*h_insert, 0, r_cyl};
Sphere(14)   = {0, -2*r_sphere - h_cyl, 0, 2*h_cyl, -Pi/11, Pi/11, 2*Pi};
Sphere(15) = {0, -2*r_sphere - h_cyl, 0, 2*h_cyl-0.2, -Pi/8, Pi/8, 2*Pi};
Box(998) = {-1, -4*r_sphere, -1, 2.5, 1.5, 2};

shell2 = BooleanDifference{ Volume{14}; Delete; }{Volume{15}; Delete;};
BooleanDifference{ Volume{shell2}; Delete; }{Volume{998}; Delete;};

// +Z
Cylinder(17) = {0, 0, r_sphere - h_insert, 0, 0, 0.5+2*h_cyl + h_insert, r_cyl};
Sphere(18)   = {0, 0, r_sphere + h_cyl, 2*h_cyl, Pi/6, Pi/2, 2*Pi};
Sphere(19)   = {0, 0, r_sphere + h_cyl, 2*h_cyl-0.2, Pi/6, Pi/2, 2*Pi};

shell3 = BooleanDifference{ Volume{18}; Delete; }{Volume{19}; Delete;};


// -Z
Cylinder(21) = {0, 0, -r_sphere + h_insert, 0, 0, -3*h_cyl - h_insert, r_cyl};
Sphere(22)   = {0, 0, -2*r_sphere - h_cyl, 2*h_cyl, -Pi/2 + 1e-3, -Pi/6 - 1e-3, 2*Pi};
Sphere(23)   = {0, 0, -2*r_sphere - h_cyl, 2*h_cyl-0.2, -Pi/2+ 1e-3, -Pi/6 - 1e-3, 2*Pi};

shell4 = BooleanDifference{ Volume{22}; Delete; }{Volume{23}; Delete;};




Mesh 3;

