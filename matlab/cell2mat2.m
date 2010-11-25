function m = cell2mat2(c, dim)
% Convert cell into matrix in dimension dim.
% eg: c: 100 x 1 cell, each cell is 4 x 4, according to dim, the size of m 
% should be: 
% dim = 1
% m is 400 * 4
% dim = 2
% m is 4 * 400
% dim = 3 (Only fesible when every cell contains equal size matrix)
% m is 4 * 4 * 100
switch num2str(dim)
    case '1'
        m = cell2mat(c);
    case '2'        
        m = cell2mat(c');
        m = m';
    case '3'
        m = [];
        for i = 1 : length(c)
            m = cat(3, m, c{i});
        end
    otherwise
        error('dim can only be 1 to 3');
end