function [BgMean, BgFwhm] = FindBgGaussModel(FrameData);

disp('Finding bg. model based on per-pixel,per-channel mode gaussian fit ...')

BgMean = [];
BgFwhm = [];
if (ndims(FrameData) == 4)
   [h,w,d,nFrames] = size(FrameData); 
elseif (ndims(FrameData) == 3)
   [h,w,nFrames] = size(FrameData);     
   d = 1;
else
    return;
end
BgMean = zeros(h,w,d);
BgFwhm = zeros(h,w,d);

binSize = 2;
bins = [0:binSize:255];
for m=1:h
    if (mod(m*20,h) ==0)
        disp([num2str(m/h*100) '%']);
    end
    for n=1:w
        for o=1:d
            hVal = hist(reshape(FrameData(m,n,o,:), [nFrames,1]), bins);
            [maxV, maxIdx] = max(hVal);
            maxVDiv2 =0.5*maxV;
            BgMean(m,n,o) = (maxIdx-1)*binSize+binSize/2;
            highFWHM = (find(hVal(maxIdx:end)<maxVDiv2, 1));
            highFWHM = highFWHM+maxIdx-1;
            lowFWHM = (find(hVal(maxIdx:-1:1)<maxVDiv2, 1));
            lowFWHM = maxIdx - lowFWHM+1;
            if isempty(lowFWHM)
               lowFWHM=1;
            end
            if isempty(highFWHM)
               highFWHM=length(bins);
            end
            BgFwhm(m,n,o) = binSize*(highFWHM-lowFWHM+1);
        end
    end
end
