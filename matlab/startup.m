format compact
load('../matrix/F30.mat')
load('../matrix/F60.mat')
global Heawood
Heawood=[
    1 1 0 0 0 1 0;
    0 1 1 0 0 0 1;
    1 0 1 1 0 0 0;
    0 1 0 1 1 0 0;
    0 0 1 0 1 1 0;
    0 0 0 1 0 1 1;
    1 0 0 0 1 0 1;
    ];
set_matlab_bgl_default(struct('nocheck',true));
    