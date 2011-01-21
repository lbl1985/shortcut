

Skin Pixel Likelihoods and Skin Detection
-----------------------------------------------

This Matlab code was developed for skin pixel detection in general imagery.

Non-parametric histogram-based models were trained using manually annotated
skin and non-skin pixels. A total of 14,985,845 skin pixels and 304,844,751
non-skin pixels were used.


I hope you find it useful.
				- Ciarán Ó Conaire (oconaire at eeng.dcu.ie)


Demo:

- Start Matlab
- change to the folder that contains TestModel.m
- run TestModel.m

The demo requires the following files to be in the same folder:
	computeSkinProbability.m
	skinmodel.bin
	normalise.m


General Usage:

	% Load an RGB image
	im = imread('image001.jpg');

	% convert the image data to doubles
	im = double(im);

	% compute the skin likelihood for each pixel
	skinprob = computeSkinProbability(im);

	% threshold the likelihood to detect skin
	skin = (skinprob > 0)+0; % zero is added to cast from a logical-typed to a double-typed matrix


	Note that the following files should be in the path:
		computeSkinProbability.m
		skinmodel.bin

