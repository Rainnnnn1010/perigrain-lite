
SetFactory("OpenCASCADE");

R       = 1.0;		// radius
h       = 2;		// height
angle   = Pi/2;         

Cylinder(1) = {0, 0, -1, 0, 0, h, R, angle};
Sphere  (2) = {0, 0,  0, 1, -Pi/2, Pi/2, 2*Pi};

pac[] = BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; };
basePac = pac[0];           


Step    = 0.5;                  
BoxSize = 5;                    // side limit
N       = BoxSize/Step;         // generate time


For i In {0:N}
  For j In {0:N}
    For k In {0:N}
      dx = i*Step;
      dy = j*Step;
      dz = k*Step;

      Translate {dx, dy, dz} {
        Duplicata{ Volume{basePac}; }
      }
    EndFor
  EndFor
EndFor

allVols[] = Volume{:};           


bigPac[] = BooleanUnion{ Volume{ allVols[] }; Delete; }{};


Mesh 3;
