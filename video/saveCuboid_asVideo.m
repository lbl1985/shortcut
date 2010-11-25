function saveCuboid_asVideo(moviefile, cuboid, fbeg, fend, cbeg, cend, framerate, clrmap)
% The functionality is the same as playCuboid_asVideo, just adding saving
% ability to save the played images as a video.  [see playCuboid_asVideo.m]
%
% INPUTS
%   moviefile   - Output video name. Eg, output.avi
%   cuboid      - The matrix with cuboid stack.
%   fbeg        - [optional] Beginning frame to play as video (if empty = 1)
%   fend        - [optional] Endding frame(if empty then = end frame)
%   cbeg        - [optional] Beginning cuboid to play as video(if empty = 1)
%   cend        - [optional] Endding frame(if empty then = end cuboid)
%   framerate	- [optional] if empty = 29
%   clrmap      - [optional] if empty = 'jet'
%
% OUTPUTS
%
% EXAMPLE
%   load cuboids.mat;
%   saveCuboid_asVideo('output.avi', cuboids);
%   saveCuboid_asVideo('output.avi', cuboids, 1, 0, 1, 0, 29, 'gray');
%
% DATESTAMP
%   24-Aug-2009  11:15am
%
% See also playCuboid_asVideo, AVIFILE, IMAGESC, ADDFRAME

% Binlong Li's Video Toolbox      Version 0.01   
% Written and maintained by Binlong Li    li.b-at-neu.edu 
% Please email me if you find bugs, or have suggestions or questions! 

nd = ndims(cuboid);  cuboidname = inputname(2); 
if nd ~= 4, error('Cuboid must be 4D'); end
if (nargin < 3 || isempty(fbeg)),           fbeg = 1;           end
if (nargin < 4 || isempty(fend)),           fend = 0;           end
if (nargin < 5 || isempty(cbeg)),           cbeg = 1;           end
if (nargin < 6 || isempty(cend)),           cend = 0;           end
if (nargin < 7 || isempty(framerate)),      framerate = 29;    end
if (nargin < 8 || isempty(clrmap)),         clrmap = 'jet';     end
if fend == 0,   fend = size(cuboid, 3);     end
if cend == 0,   cend = size(cuboid, 4);     end

aviobj = avifile(moviefile, 'fps', framerate, 'compression', 'none');

for i = cbeg : cend
    for j = fbeg : fend
        imagesc(cuboid(:, :, j, i)); colormap(clrmap); colorbar;
        title(sprintf('%s\nCuboid%d\tFrame%d', cuboidname, i, j));
        pause(1/29);
        frame = getframe(gcf);
        aviobj = addframe(aviobj, frame);
    end
end
aviobj = close(aviobj);