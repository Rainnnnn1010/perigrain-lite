SetFactory("OpenCASCADE");

dx = 2; dy = 1; dz = 1;  

// middle： x axis
Box(1) = {-dx/2, -dy/2, -dz/2, dx, dy, dz};

// left：绕 z 轴旋转 -90°）
Box(2) = {-dx/2, -dy/2, -dz/2, dx, dy, dz};  
Rotate {{0, 0, 1}, {0, 0, 0}, -Pi/2} { Volume{2}; }
Translate {-1.5*dy, 0, 0} { Volume{2}; } // 向负 x 移动一段（原来 y 长度变成 x 向）

// right：绕 y 轴旋转 +90
Box(3) = {-dx/2, -dy/2, -dz/2, dx, dy, dz};
Rotate {{0, 1, 0}, {0, 0, 0}, Pi/2} { Volume{3}; }
Translate {1.5*dz, 0, 0} { Volume{3}; }  // 向正 x 移动





Physical Volume("CrossDumbbell") = {1};

