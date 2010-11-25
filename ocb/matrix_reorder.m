function [b ix] = matrix_reorder(m)

b=m;
ix = zeros(size(m));

for j=1:size(m,1)
    [s, idx] = sort(b(j,j:end), 'descend');
    b(j, j : end) = s;
    b(j : end, j) = s';
    ix(j, j : end) = idx;
end
