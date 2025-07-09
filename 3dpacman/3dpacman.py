// ------------------------------------------------------------
//  Pac-Man Lattice without Overlaps (explicit If-Else for alpha)
// ------------------------------------------------------------
SetFactory("OpenCASCADE");

// ---------- 基础参数 ----------
R          = 1.0;        // 球半径
h          = 2;          // 圆柱高度
mouthAngle = Pi/2;       // Pac-Man 嘴巴张角
Step       = 0.5;        // 网格间距
BoxSize    = 5;          // 网格大小
N          = BoxSize/Step;  // 复制次数 (每轴)

// ---------- Pac-Man 原型 ----------
Cylinder(1) = {0, 0, -h/2,  0, 0, h,  R, mouthAngle};
Sphere  (2) = {0, 0,   0,   R, -Pi/2, Pi/2, 2*Pi};

pac[]   = BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; };
basePac = pac[0];   // ID of the original Pac-Man at (0,0,0)

// ---------- 复制 + 避免与原型重叠 ----------
For i In {0:N}
  For j In {0:N}
    For k In {0:N}

      dx = i*Step;
      dy = j*Step;
      dz = k*Step;

      // 与 basePac 球心的平方距离
      d2 = dx*dx + dy*dy + dz*dz;

      // 若不会和 basePac 重叠才复制
      If ( d2 >= (2*R)^2 - 1e-8 )

        // ---------------- 计算 alpha ----------------
        If ( ((i + j + k) % 2) == 1 )
          alpha = Pi;   // 奇数格：旋转 180°
        Else
          alpha = 0;    // 偶数格：不旋转
        EndIf
        // -------------------------------------------

        Translate {dx, dy, dz} {
          Rotate {0, 0, 0} {0, 0, 1, alpha} {
            Duplicata{ Volume{basePac}; }
          }
        }
      EndIf

    EndFor
  EndFor
EndFor

Mesh 3;
