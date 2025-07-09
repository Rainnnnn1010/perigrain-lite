SetFactory("OpenCASCADE");

lc = 0.1;

L = 0.4;

For i In {0:4}
  // center position
  
  xc = 2*Rand(1) - 1;
  yc = 2*Rand(1) - 1;
  zc = 2*Rand(1) - 1;

	
  // 左下后角坐标
  x0 = xc - L/2;
  y0 = yc - L/2;
  z0 = zc - L/2;

  // 自动获取新 Volume ID
  v  = newv;
  Box(v) = {x0, y0, z0, L, L, L};
EndFor


Mesh 3;

