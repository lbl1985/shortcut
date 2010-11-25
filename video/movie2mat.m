function movie2mat(filename)

% path = pwd; pathold = path;
% path = [path '\video'];
% % movie2frames(filename);
% saveImages_asMat(path, 'jpg', 1, 0, pathold, 'video');
% cd video
% !del *.jpg
% cd ..
% !rmdir video
video = mmread(filename);
n = length(video.frames);
mat = zeros(video.height, video.width ,3, n);
for i = 1 : n
    mat(:, :, :, i) = video.frames(i).cdata;
end
save mat mat