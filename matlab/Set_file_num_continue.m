function Set_file_num_continue(ofile, oext, tfile, text)
% Set_file_num_continue(ofile, oext, tfile, text)
% ofile = orignial filename, oext = orignial extern
% tfile = target filename, text = target extern
s = sprintf('*%s', oext);
k = ls(s);
for i = 1 : size(k, 1)
    if (k(i, 1 : size(ofile, 2)) == ofile)
        I = imread(k(i, :));
        s = sprintf('%s%d%s', tfile, i, text);
        imwrite(I, s);
    end
end