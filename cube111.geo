SetFactory("OpenCASCADE");

Box(1) = {0, 0, 0, 1, 1, 1};

lc = 0.4;

//  8 个角坐标:
// (0,0,0), (1,0,0), (0,1,0), (1,1,0),
// (0,0,1), (1,0,1), (0,1,1), (1,1,1)

Box(2)  = {0, 0, 0, lc, lc, lc};
Box(3)  = {1 - lc, 0, 0, lc, lc, lc};
Box(4)  = {0, 1 - lc, 0, lc, lc, lc};
Box(5)  = {1 - lc, 1 - lc, 0, lc, lc, lc};
Box(6)  = {0, 0, 1 - lc, lc, lc, lc};
Box(7)  = {1 - lc, 0, 1 - lc, lc, lc, lc};
Box(8)  = {0, 1 - lc, 1 - lc, lc, lc, lc};
Box(9)  = {1 - lc, 1 - lc, 1 - lc, lc, lc, lc};


BooleanDifference { Volume{1}; Delete;} { Volume{2}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{3}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{4}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{5}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{6}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{7}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{8}; Delete;}
BooleanDifference { Volume{1}; Delete;} { Volume{9}; Delete;}
