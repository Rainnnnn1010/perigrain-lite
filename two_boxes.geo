
SetFactory("OpenCASCADE");
Box(1) = {0, 0, 0, 1, 1, 1};
Box(2) = {0.5, 0.5, 0.5, 1, 1, 1};
BooleanUnion{ Volume{1}; Delete; }{ Volume{2}; Delete; }
Mesh 3;
