function R_draw = drawbox(R_normal, lefttop, rightbottom)

maxV = max(R_normal(:));
R_normal(lefttop(1) : rightbottom(1), lefttop(2), :) = 0.5 * maxV;
R_normal(lefttop(1) : rightbottom(1), rightbottom(2), :) = 0.5 * maxV;
R_normal(lefttop(1), lefttop(2) : rightbottom(2), :) = 0.5 * maxV;
R_normal(rightbottom(1), lefttop(2) : rightbottom(2), :) = 0.5 * maxV;
R_draw = R_normal;
end