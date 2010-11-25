function y = skm(u)
% skew-symmetric matrices.
% a = [a1; a2; a3]; y = [ 0 -a3 a2; a3 0 -a1; -a2 a1 0];
% A4.2 P581. Multiple View of Geometry in Computer Vision
[m n] = size(u);
if m == 3 && n == 1
    y = [0 -u(3) u(2); u(3) 0 -u(1); -u(2) u(1) 0];
else
    y = 0;
    error('For obtaining skew-symmetric matrices, the u must be 3 by 1 matrix');    
end
    