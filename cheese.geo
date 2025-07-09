SetFactory("OpenCASCADE");

lc = 1e-1;

Point(1) = {1, 0, 0, lc};  // Start point
Point(2) = {0, 0, 0, lc};    // Center
Point(3) = {Cos(Pi/4), Sin(Pi/4), 0, lc};    // End
 
Point(4) = {0.99,0,0,lc};
Point(5) ={0.99*Cos(Pi/4), 0.99*Sin(Pi/4), 0, lc};
 
// 
Circle(1) = {1, 2, 3};     // Arc
Line(2) = {2, 1};   
Line(3) = {3, 2};    
 
Circle(6) = {4,2,5};
Line(4) = {2,4};
Line(5) = {5,2};
 
// surface
Curve Loop(1) = {2, 1, -3};  
Curve Loop(2) = {4,6,-5};
Plane Surface(1) = {1};
Plane Surface(2) = {2};
//+
Extrude {0, 0, 1} {
  Surface{1}; 
}
 
//+
Extrude {0, 0, 1} {
  Surface{2}; 
}
