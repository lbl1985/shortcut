function tline = file2str(filename)
% tline = file2str(filename)
% read the contents of a file into a varable, and set them into char. And
% the returen value is one line and # columns.
    fid = fopen(filename, 'r');
    tline = fread(fid, '*char');
    tline = tline';
