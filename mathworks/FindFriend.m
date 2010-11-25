function [tt, xx, yy, t, x, y] = FindFriend(tt, xx, yy, t, x, y)
% clear
% clc
% tt = [1 2 3 4 4 5 6.5 8 9 9 10]';
% t = [1 2 3 4 5 5 7 7.5 8 9 9 9.5]';

[tt Index_tt] = unique(tt);
[t Index_t] = unique(t);

xx = selected(xx, Index_tt);
yy = selected(yy, Index_tt);

x = selected(x, Index_t);
y = selected(y, Index_t);

index_tt = [];
index_t = [];
j = 1;

for i = 1 : length(tt)
    if isequal(tt(i), t(j))
        index_tt = [index_tt i];
        index_t = [index_t j];
        j = j + 1;
    elseif ~isequal(tt(i), t(j))
        tArray = tt(i) * ones((length(t) - j + 1), 1);
        if isempty(find((tArray - t(j:end))== 0))
            j = j + 1;
        else 
            j = j + find((tArray - t(j : end)) == 0) - 1;
            index_tt = [index_tt i];
            index_t = [index_t j];
        end       
    end
end

tt = tt([index_tt]);
xx = selected(xx, index_tt);
yy = selected(yy, index_tt);

t = t([index_t]);
x = selected(x, index_t);
y = selected(y, index_t);

end