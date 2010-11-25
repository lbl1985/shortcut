function ftc = clipsdesc2ftc_loc(sub, data, k, n, m)
% ftc ---- Feature Time Count
% This function will try to creat a matrix with k(#cluster) x f(#frames) for each
% clip. The matrix contains the information for each cluster chaning with
% time. 
% where the n = fmin, m = fmax; 
% Compare to the function clipsdesc2ftc;

t = sub(:, 3);
% m = max(t); n = min(t);

f = m - n + 1;
ftc = zeros(k, f);
% [B, IX] = sort(data);
for i = 1 : k
    % tf is the frames with feature i
    tf = t(data == i);
    count = histc(tf, (n - .5) : (m + .5));
    count = count(1 : end - 1);
    ftc(i , :) = count;
end