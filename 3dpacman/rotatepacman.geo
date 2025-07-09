
SetFactory("OpenCASCADE");

R       = 1.0;		// radius
h       = 2;		// height
angle   = Pi/2;         

Step    = 0.5;                  
BoxSize = 5;                    // side limit
N       = BoxSize/Step;         // generate time

RotNum   = 8;              // Number of rotations
dPhi   = 2*Pi/RotNum;      // angle rotate



Cylinder(1) = {0,0,-1, 0,0,h, R, angle};
Sphere  (2) = {0,0, 0, 1, -Pi/2, Pi/2, 2*Pi};
pac[]       = BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; };
basePac     = pac[0];



For p In {0:RotN-1}
  phi = p * dPhi;              // the angle that rotates

  For i In {0:N}
    For j In {0:N}
      For k In {0:N}
        dx = i * Step;
        dy = j * Step;
        dz = k * Step;

      
        newVol() = Duplicata{ Volume{basePac}; };
        Rotate   {{0,0,1},{0,0,0}, phi} { Volume{newVol()}; }
        Translate{dx, dy, dz}            { Volume{newVol()}; }
      EndFor
    EndFor
  EndFor
EndFor

Mesh 3;

