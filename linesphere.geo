lc = 0.05;
r = 1;
n_theta = 4;
n_phi = 4;
arrow_size = 0.2;

Point(1) = {0, 0, 0, lc};

pt_id = 2;     // 点编号从2开始
ln_id = 1;     // 线编号
arrow_id = 1000; // 箭头末端点从1000开始
arrow_ln = 5000; // 箭头线段从5000开始

// === 球面发射主线 + 每个点添加箭头伞骨 ===
For i In {1:(n_theta - 1)} // 排除极点
  theta = Pi * i / n_theta;
  For j In {0:(n_phi - 1)}
    phi = 2 * Pi * j / n_phi;

    // 球面坐标 → 直角坐标
    x = r * Sin(theta) * Cos(phi);
    y = r * Sin(theta) * Sin(phi);
    z = r * Cos(theta);

    // 球面点
    Point(pt_id) = {x, y, z, lc};
    Line(ln_id) = {1, pt_id}; // 主线
    ln_id += 1;

   // 添加三根伞骨：x, y, z 三方向短偏移
    Point(arrow_id + 1) = {x + arrow_size, y, z, lc};
    Line(arrow_ln + 1) = {pt_id, arrow_id + 1};

    Point(arrow_id + 2) = {x, y + arrow_size, z, lc};
    Line(arrow_ln + 2) = {pt_id, arrow_id + 2};

    Point(arrow_id + 3) = {x, y, z + arrow_size, lc};
    Line(arrow_ln + 3) = {pt_id, arrow_id + 3};

    // 更新编号
    pt_id += 1;
    arrow_id += 3;
    arrow_ln += 3;
  EndFor
EndFor

// === 添加极点线段 ===
Point(pt_id) = {0, 0, r, lc}; Line(ln_id) = {1, pt_id}; pt_id += 1; ln_id += 1;
Point(pt_id) = {0, 0, -r, lc}; Line(ln_id) = {1, pt_id};


