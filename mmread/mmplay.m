function movie = mmplay(varargin)
 [filename frames] = deal(varargin{:});

if isempty(frames)
    movie = mmread(filename);
else
    movie = mmread(filename, frames);
end

for i = 1: movie.nrFramesTotal
    imshow(movie.frames(i).cdata);
    pause(1/22);
end