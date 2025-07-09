
SetFactory("OpenCASCADE");

R       = 1;		// radius
h       = 2;		// height
angle   = Pi/2;     // cylinder angle (mouth angle)

Cylinder(1) = {0, 0, -1, 0, 0, h, R, angle};
Sphere  (2) = {0, 0,  0, 1, -Pi/2, Pi/2, 2*Pi};

Step    = 0.5;                  
BoxSize = 5;                    // side limit
N       = BoxSize/Step;         // generate time


pac[] = BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; };
basePac = pac[0];           

/*

  
For i In {0:N}
  For j In {0:N}
    For k In {0:N}
      dx = i*Step;
      dy = j*Step;
      dz = k*Step;

      d2 = dx*dx + dy*dy + dz*dz;   //distance from the sphere center
      If ( d2 >= (2*R)^2 - 1e-8 )   // remove the intersect part
        Translate {dx, dy, dz} {
          Duplicata { Volume{basePac}; }
        }
      EndIf

    EndFor
  EndFor
EndFor

//union all shapes (need adjustment)

//   ------ method 1 --------                
//shell1 = BooleanUnion{ Volume{all[]}; Delete; }{Volume{basePac}; Delete;};

//   ------ method 2 --------   
//allVols[] = Volume{:};   
//bigPac[] = BooleanUnion{ Volume{ allVols[] }; Delete; }{};



//rotate pac
RotNum   = 8;              // Number of rotations
dPhi   = 2*Pi/RotNum;      // angle rotate

For p In {0:RotNum}
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



*/


Mesh 3;
