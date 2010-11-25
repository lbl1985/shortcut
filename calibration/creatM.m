function M = creatM(fc, cc)
M = zeros(3,3);
M(1, 1) = fc(1);
M(2, 2) = fc(2);
M(1:2, 3) = cc;
M(3, 3) = 1;