im = imread('P1020809.jpg');
figure(1); subplot(1, 2, 1); imshow(im);
im = double(im);
skinprob = computeSkinProbability(im);
skin = (skinprob >0) + 0;
figure(1); subplot(1, 2, 2); imshow(skin)