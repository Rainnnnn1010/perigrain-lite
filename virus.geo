SetFactory("OpenCASCADE");

lc        = 0.1;    
r_sphere  = 0.5;    
r_cyl     = 0.15;   // 圆柱半径
h_cyl     = 0.5;    // 圆柱长度
h_insert  = r_cyl;  // 圆柱球体重叠度
h_top     = 0.15;   // top厚度

Sphere(1) = {0, 0, 0, r_sphere};

// +X

Cylinder(2) = {r_sphere - h_insert, 0, 0, h_cyl + h_insert, 0, 0, r_cyl};

Sphere(3) = {r_sphere + h_cyl, 0, 0, r_sphere};
Box(4)    = {r_sphere + h_cyl, -2*r_cyl, -2*r_cyl, h_top, 4*r_cyl, 4*r_cyl};
topXplus[]  = BooleanIntersection{ Volume{3}; Delete; }{ Volume{4}; Delete; };


spikeXplus[] = BooleanUnion{ Volume{2}; Delete; }{ Volume{topXplus[]}; Delete; };


ballXplus[] = BooleanUnion{ Volume{1}; Delete; }{ Volume{spikeXplus[]}; Delete; };


// -X
Cylinder(5) = {-r_sphere + h_insert, 0, 0, -h_cyl - h_insert, 0, 0, r_cyl};
Sphere(6) = {-r_sphere - h_cyl, 0, 0, r_sphere};
Box(7)    = {-r_sphere - h_cyl - h_top, -2*r_cyl, -2*r_cyl, h_top, 4*r_cyl, 4*r_cyl};
topXminus[]  = BooleanIntersection{ Volume{6}; Delete; }{ Volume{7}; Delete; };
spikeXminus[] = BooleanUnion{ Volume{5}; Delete; }{ Volume{topXminus[]}; Delete; };
ballX[] = BooleanUnion{ Volume{ballXplus[]}; Delete; }{ Volume{spikeXminus[]}; Delete; };


// +Y
Cylinder(9) = {0, r_sphere - h_insert, 0, 0, h_cyl + h_insert, 0, r_cyl};
Sphere(10)  = {0, r_sphere + h_cyl, 0, r_sphere};
Box(11)     = {-2*r_cyl, r_sphere + h_cyl, -2*r_cyl, 4*r_cyl, h_top, 4*r_cyl};
topYplus[]  = BooleanIntersection{ Volume{10}; Delete; }{ Volume{11}; Delete; };
spikeYplus[] = BooleanUnion{ Volume{9}; Delete; }{ Volume{topYplus[]}; Delete; };
ballYplus[] = BooleanUnion{ Volume{ballX[]}; Delete; }{ Volume{spikeYplus[]}; Delete; };


// -Y
Cylinder(13) = {0, -r_sphere + h_insert, 0, 0, -h_cyl - h_insert, 0, r_cyl};
Sphere(14)   = {0, -r_sphere - h_cyl, 0, r_sphere};
Box(15)      = {-2*r_cyl, -r_sphere - h_cyl - h_top, -2*r_cyl, 4*r_cyl, h_top, 4*r_cyl};
topYminus[]  = BooleanIntersection{ Volume{14}; Delete; }{ Volume{15}; Delete; };
spikeYminus[] = BooleanUnion{ Volume{13}; Delete; }{ Volume{topYminus[]}; Delete; };
ballY[] = BooleanUnion{ Volume{ballYplus[]}; Delete; }{ Volume{spikeYminus[]}; Delete; };


// +Z
Cylinder(17) = {0, 0, r_sphere - h_insert, 0, 0, h_cyl + h_insert, r_cyl};
Sphere(18)   = {0, 0, r_sphere + h_cyl, r_sphere};
Box(19)      = {-2*r_cyl, -2*r_cyl, r_sphere + h_cyl, 4*r_cyl, 4*r_cyl, h_top};
topZplus[]   = BooleanIntersection{ Volume{18}; Delete; }{ Volume{19}; Delete; };
spikeZplus[] = BooleanUnion{ Volume{17}; Delete; }{ Volume{topZplus[]}; Delete; };
ballZplus[] = BooleanUnion{ Volume{ballY[]}; Delete; }{ Volume{spikeZplus[]}; Delete; };


// -Z
Cylinder(21) = {0, 0, -r_sphere + h_insert, 0, 0, -h_cyl - h_insert, r_cyl};
Sphere(22)   = {0, 0, -r_sphere - h_cyl, r_sphere};
Box(23)      = {-2*r_cyl, -2*r_cyl, -r_sphere - h_cyl - h_top, 4*r_cyl, 4*r_cyl, h_top};
topZminus[]  = BooleanIntersection{ Volume{22}; Delete; }{ Volume{23}; Delete; };
spikeZminus[] = BooleanUnion{ Volume{21}; Delete; }{ Volume{topZminus[]}; Delete; };
final[] = BooleanUnion{ Volume{ballZplus[]}; Delete; }{ Volume{spikeZminus[]}; Delete; };


Mesh 3;

