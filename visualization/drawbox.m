function R_draw = drawbox(R_normal, lefttop, rightbottom, varargin)
if nargin < 4
    per = 0.5;
else
    per = varargin{1};
end
maxV = max(R_normal(:));
R_normal(lefttop(1) : rightbottom(1), lefttop(2), :) = per * maxV;
R_normal(lefttop(1) : rightbottom(1), rightbottom(2), :) = per * maxV;
R_normal(lefttop(1), lefttop(2) : rightbottom(2), :) = per * maxV;
R_normal(rightbottom(1), lefttop(2) : rightbottom(2), :) = per * maxV;
R_draw = R_normal;
end