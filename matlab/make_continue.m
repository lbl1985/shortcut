function make_continue(ext)
% make_continue('.jpg')
% Make all the .jpg files under the working path into a continue order.
s = sprintf('*%s', ext);
k = ls(s);
n = 1;

for i = 1 : size(k, 1)
    s = k(i, :);
    st = sprintf('%s_%d%s', k(i, 1: 7), n, ext);
    c = sprintf('!rename %s %s', s, st);
    eval(c);
    n = n + 1;
end