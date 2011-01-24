function varargout = mat2frames(mat, varargin)
if nargin == 3
    dest = varargin{1};
    filename = varargin{2};
    %     movie = varargin{2};
    if ispc
        k = strfind(filename, '\');
    else
        k = strfind(filename, '/');
    end
    %     olderpath = pwd;
    % movie = mmread(filename);
    nFrame = size(mat, ndims(mat));
    varargout{1} = nFrame;
    nDigtal = 4;
    if ~exist(dest, 'dir')
        mkdir(dest);
    end
    cd(dest);
    filenameT = filename(k(end) + 1 : end-4);
    for i = 1 : nFrame
        I = movie.frames(i).cdata;
        imwrite(I, [filenameT '_' int2str2(i, nDigtal), '.jpg']);
    end
end