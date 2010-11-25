function movie2frames(filename)
% Change the movie into .jpg frames. 
% The save file will be saved in the path with movie name
% Files name will be: movie name + Frame#
% Example:
% movie2frames('singleCameraOutput2.wmv');
olderpath = pwd;
movie = mmread(filename);
nFrame = movie.nrFramesTotal;
nDigtal = ceil(log10(nFrame));
mkdir(filename(1:end-4)); cd(filename(1:end-4));
for i = 1 : nFrame
    I = movie.frames(i).cdata;
    imwrite(I, [filename(1:end-4) '_' int2str2(i,nDigtal) '.jpg']);
end
cd (olderpath);