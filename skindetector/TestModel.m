
%
% Testing code for skin-pixel likelihood model
% (written and tested at the Centre for Digital Video Processing by Ciarán Ó Conaire)
%


% List all JPGs in current folder
froot = '.'
list = dir(sprintf('%s\\*.jpg', froot));

% Process each image
for index = 1:length(list)
    % load image and compute skin likelihood
    fn = sprintf('%s\\%s', froot, list(index).name);
    im = double(imread(fn));
    skinprob = computeSkinProbability(im);

    subplot(1,1,1);
    image(im/255);
    title('Input Image')
    pause;

    % show skin-likelihood image
    image(normalise(skinprob)*64);
    colormap('default');
    title(sprintf('Skin likelihood of each pixel: Min=%2.2f, Max=%2.2f', min(min(skinprob)), max(max(skinprob))));
    pause

    % compute and display a binary skin map using a threshold of 0
    image((skinprob>0)*64);
    colormap('gray');
    title('Likelihood thresholded at zero');
    pause

    % show the original image, but replace the red band with the binary skin image
    im2=im;
    im2(:,:,1) = (skinprob>0)*255;
    image(im2/255);
    title('Overlay')
    pause;

end

