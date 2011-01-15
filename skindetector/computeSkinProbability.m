function skinprob = computeSkinProbability(im)

persistent smodel;

if (isempty(smodel))
    % load skin model
    skinmodfn = 'skinmodel.bin';
    fid = fopen(skinmodfn, 'rb');
    tmp = fread(fid, inf, 'real*4');
    fclose(fid);
    K = 32;
    smodel = zeros(K,K,K);
    smodel(:) = tmp(:);
    clear tmp
end

if (size(im,3) ~= 3)
    warning('Input image does not have 3 bands. RGB image required.');
    skinprob = [];
    return
end

im = double(im);
im2 = 1 + floor(im(:,:,1)/8)+floor(im(:,:,2)/8)*32+floor(im(:,:,3)/8)*32*32; % 32 bins

skinprob = smodel(im2);



