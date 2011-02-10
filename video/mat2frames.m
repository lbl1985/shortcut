function varargout = mat2frames(mat, varargin)
% Input:
% mat: Object matrix
% dest: destination for saving images.
% filename: it could be the output of rfdatabase, or the saving images file
% name w/o ext.
% ext: saving files externsion.

olderpath = pwd;
if nargin == 4
    dest = varargin{1};
    filename = varargin{2};
    ext = varargin{3};
    %     movie = varargin{2};
    %     if nargin < 5
    if ispc
        k = strfind(filename, '\');
    else
        k = strfind(filename, '/');
    end
    %     end
    %     olderpath = pwd;
    % movie = mmread(filename);
    nFrame = size(mat, ndims(mat));
    varargout{1} = nFrame;
    nDigtal = 3;
    if ~exist(dest, 'dir')
        mkdir(dest);
    end
    cd(dest);
    if ~isempty(k)
        filenameT = filename(k(end) + 1 : end-4);
    else
        filenameT = filename;
    end
    for i = 1 : nFrame
        if ndims(mat) == 3
            I = mat(:, :, i);
        elseif ndims(mat) == 4
            I = mat(:, :, :, i);
        else
            error('We can only handle ndims(M) == 3 or 4');
        end
        %         I = movie.frames(i).cdata;
        imwrite(I, [filenameT '_' int2str2(i, nDigtal), '.' ext]);
    end
end
cd(olderpath)