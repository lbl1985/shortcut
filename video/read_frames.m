function I = read_frames(fbeg, fend, interval, filename)
% read_frames(fbeg, fend, interval, filename)
% if fend == 0; fend = NumberOfFrames;
% Example: read_frames(1, 0, 3, 'intrisic.avi');

movie = mmreader(filename);

if fend == 0
    fend = get(movie, 'NumberOfFrames');
end
vidFrame = read(movie, [1 2]);
[m n d] = size(vidFrame(:, :, :, 1));
I = zeros(m, n, d);
k = 1;
for i = fbeg : interval : fend
    vidFrames = read(movie, [i i + 1]);
    imshow(vidFrames(:, :, :, 1));
    I = vidFrames(:, :, :, 1);
%     s = sprintf('Calib%d.tif', k);
%     imwrite(I, s);
%     k = k + 1;    
    s = sprintf('Frame %d', i);
    title(s);
    pause(.1);
end
