SetFactory("OpenCASCADE");

// ---------- 基础参数 ----------
R          = 1.0;        // 球半径
h          = 2;          // 圆柱高度
mouthAngle = Pi/2;       // 嘴巴张开角 (圆柱截角)
Step       = 0.5;        // 网格间距
BoxSize    = 5;          // 网格边长
N          = BoxSize/Step;  // 复制次数 (每轴)

// ---------- 构造 Pac-Man 原型 ----------
Cylinder(1) = {0, 0, -h/2,  0, 0, h,  R, mouthAngle}; // 截掉 90°
Sphere  (2) = {0, 0,   0,   R, -Pi/2, Pi/2, 2*Pi};

pac[]   = BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; };
basePac = pac[0];   // 一个干净的 Pac-Man 原型

// ---------- 复制 + 旋转 + 平移 ----------
For i In {0:N}
  For j In {0:N}
    For k In {0:N}
      dx = i * Step;
      dy = j * Step;
      dz = k * Step;

      // 让 (i+j+k) 奇偶决定嘴巴朝向：偶数 = 0°，奇数 = 180°
      alpha = ((i + j + k) % 2) ? Pi : 0;  // 弧度

      // 先旋转后平移
      Translate {dx, dy, dz} {
        Rotate {0, 0, 0} {0, 0, 1, alpha} {  // 绕 z 轴旋转 alpha
          Duplicata { Volume{basePac}; }
        }
      }
    EndFor
  EndFor
EndFor

Mesh 3;
