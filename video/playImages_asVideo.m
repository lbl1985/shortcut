function playImages_asVideo(path, ext)

if isempty(path)
    path = pwd;
end

[srcdir filenames n] = rfdatabase(path, [], ext);
for i = 1 : n
    imshow([srcdir filenames{i}]); title(['Frame ' num2str(i)]);
    pause(1/22);
end