% function gofile(str)
%     str = sprintf([matlabroot '/%s'],str);
%     edit(str);
% end

function str = gofile(filename)
fid = fopen(filename);
if fid == -1
    fprintf(1, 'Failed to open file "%s" for reading.\n', fileName);
    error('Failed to open file %s', fileName);
end

F = fread(fid);
str = char(F');
fclose(fid);
