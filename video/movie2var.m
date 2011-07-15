function mat = movie2var(filename, isGray, siz)
% isGray could be []. The program will reserve the original format
if ~ispc
    currPath = pwd;
end
video = mmread(filename);
n = length(video.frames);

if isempty(isGray)
    % user dont' specifically require for gray or rgb. Then save it as the
    % original format
    sampleFrame = video.frames(1).cdata;
    if ndims(sampleFrame) > 3
        isGray = 0;
    else
        isGray = 1;
    end
end

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