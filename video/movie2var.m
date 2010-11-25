function mat = movie2var(filename, isGray, siz)
if ~ispc
    currPath = pwd;
end
video = mmread(filename);
n = length(video.frames);

if ~isGray
    mat = uint8(zeros(video.height * siz, video.width * siz ,3, n));    
    for i = 1 : n
        mat(:, :, :, i) = uint8(imresize(video.frames(i).cdata, siz));        
    end
else
    
    mat = uint8(zeros(video.height * siz, video.width * siz, n));
    for i = 1 : n
        mat(:, :, i) = uint8(imresize(rgb2gray(video.frames(i).cdata), siz));
    end
end

if ~ispc
    cd(currPath);
end