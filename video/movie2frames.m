function varargout = movie2frames(filename, varargin)
% Change the movie into .jpg frames. 
% The save file will be saved in the path with movie name
% Files name will be: movie name + Frame#
% Example:
% movie2frames('singleCameraOutput2.wmv');
olderpath = pwd;
if nargin == 1    
    movie = mmread(filename);
    nFrame = movie.nrFramesTotal;
    nDigtal = ceil(log10(nFrame));
    mkdir(filename(1:end-4)); cd(filename(1:end-4));
    for i = 1 : nFrame
        I = movie.frames(i).cdata;
        imwrite(I, [filename(1:end-4) '_' int2str2(i,nDigtal) '.jpg']);
    end  
else
    dest = varargin{1};
%     movie = varargin{2};
    if ispc
        k = strfind(filename, '\');
    else
        k = strfind(filename, '/');
    end
%     olderpath = pwd;
    movie = mmread(filename);
    nFrame = movie.nrFramesTotal;
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
cd (olderpath);