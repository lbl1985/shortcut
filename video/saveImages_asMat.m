function saveImages_asMat(path, ext, fbeg, fend, savingpath, varargin)
% This function is for batching saving any images into .mat format.
% INPUTS
%   path        - folder where the images live
%   ext         - ext for images
%   fbeg        - [optional] Beginning frame to save as video (if empty = 1)
%   fend        - [optional] Endding frame(if 0 then = end frame)
%   savingpath  - path, where the .mat file will be grown up.
%
% OUTPUTS
%
% EXAMPLE
%   saveImages_asMat('C:\Users\lbl1985\Desktop\binlong_segmentation\50perce
%   nt\box\person01_boxing_d1_uncomp', 'jpg', 1, 0, 'C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\KTH\ForeGroundData2\boxing\');
%
% DATESTAMP
%   15-April-2010  18:20
%
% See also AVIFILE, IMAGESC, ADDFRAME, saveM_asVideo

% Binlong Li's Video Toolbox      Version 1.0   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 

if nargin < 4,  fbeg = 1;   end
if nargin < 5,  fend = 0;   end
if nargin == 6, savingname = varargin{1}; end

[srcdir filenames n] = rfdatabase(path, [], ext);

if fend == 0;   fend = n;   end

I = imread([srcdir filenames{1}]);
ForeGround = zeros(size(I, 1), size(I, 2), n);
for i = fbeg : fend
    ForeGround(:, :, i) = imread([srcdir filenames{i}]);
end

if nargin < 6
    save([savingpath srcdir(end - 25: end - 1) '.mat'], 'ForeGround');
else 
    save([savingpath savingname '.mat'], 'ForeGround');
end