function R_ftc = R2R_ftc(R_nor, beg, gap)

% beg = .05;    gap = 1/20; 
t = size(R_nor, 3);
R_ftc = zeros(length(beg : gap: 1), t);
for i = 1 : t
    Rt = R_nor(:, :, i);
    count = histc(Rt(:), beg : gap : 1);
    R_ftc(:, i) = count';
end