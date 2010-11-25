function ftc = clipsdesc2ftc_w(sub, data, k, R)
% Accound weight for the count.
% ftc ---- Feature Time Count
% This function will try to creat a matrix with k(#cluster) x f(#frames) for each
% clip. The matrix contains the information for each cluster chaning with
% time. 
% Relevant:
% clipsdesc2ftc
t = sub(:, 3);
m = max(t); n = min(t);

f = m - n + 1;
ftc = zeros(k, f);
R_floor = floor(100 * R);
% [B, IX] = sort(data);
for i = 1 : k
    % tf is the frames with feature i
    tf = t(data == i);  w = R_floor(data == i);
    tf = weightfun(tf, w);
    count = histc(tf, (n - .5) : (m + .5));
    count = count(1 : end - 1);
    ftc(i , :) = count;
end