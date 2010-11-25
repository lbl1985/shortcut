function playCuboid_asVideo(cuboid, fbeg, fend, cbeg, cend, pause_time, clrmap)
% [4D] Used to play a stack of T cuboids as a video. 
% The cuboid should be 4D, such as, size(cuboids) = 37 by 37 by 17 by 25,
% which means we have 25 cuboids, each of them are size of 37 by 37 by 17.
% The 3d dimension represents the frames of original video.
%
% Note: fbeg, fend --- frame begin,  frame end
%       cbeg, cend --- cuboid begin, cuboid end
%
% INPUTS
%   cuboid      - The matrix with cuboid stack.
%   fbeg        - [optional] Beginning frame to play as video (if empty = 1)
%   fend        - [optional] Endding frame(if empty then = end frame)
%   cbeg        - [optional] Beginning cuboid to play as video(if empty = 1)
%   cend        - [optional] Endding frame(if empty then = end cuboid)
%   pause_time	- [optional] if empty = 22
%   clrmap      - [optional] if empty = 'jet'
%
% OUTPUTS
%
% EXAMPLE
%   load cuboids.mat;
%   playCuboid_asVideo(cuboids);
%
% DATESTAMP
%   24-Aug-2009  10:00am
%
% See also playM_asVideo, saveM_asVideo

% Binlong Li's Video Toolbox      Version 0.01   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 

nd = ndims(cuboid);  cuboidname = inputname(1); 
if nd ~= 4, error('Cuboid must be 4D'); end
if (nargin < 2 || isempty(fbeg)),           fbeg = 1;           end
if (nargin < 3 || isempty(fend)),           fend = 0;           end
if (nargin < 4 || isempty(cbeg)),           cbeg = 1;           end
if (nargin < 5 || isempty(cend)),           cend = 0;           end
if (nargin < 6 || isempty(pause_time)),     pause_time = 22;    end
if (nargin < 7 || isempty(clrmap)),         clrmap = 'jet';     end
if fend == 0,   fend = size(cuboid, 3);     end
if cend == 0,   cend = size(cuboid, 4);     end

for i = cbeg : cend
    for j = fbeg : fend
        imagesc(cuboid(:, :, j, i)); colormap(clrmap); colorbar;
        title(sprintf('%s\nCuboid%d\nFrame%d', cuboidname, i, j));
        pause(1/pause_time);
    end
end
