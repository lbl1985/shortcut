clear;

%% Initialization and parameters
nT			= 10;		%number of T
n_sample	= 600;		%number of particles

if ispc
    res_path	= 'result\pktest02\'; %folder for the tracking result
else
    res_path	= 'result/pktest02/'; %folder for the tracking result
end

%preparing frames
if ispc
    fprefix		= 'pktest02\frame';%folder storing the images
else
    fprefix		= 'pktest02/frame';%folder storing the images
end
fext		= 'jpg';				%image format
start_frame	= 1087;					%starting frame number
nframes		= 120;					%number of frames to be tracked
sz_T		= [12 15];	%size of the template
numzeros	= 5;	%number of digits for the frame index

s_frames	= cell(nframes,1);

nz			= strcat('%0',num2str(numzeros),'d'); %number of zeros in the name of image
for t=1:nframes
    image_no	= start_frame + (t-1);
    fid			= sprintf(nz, image_no);
    s_frames{t}	= strcat(fprefix,fid,'.',fext);
end

%initialization
%	init_pos	- target selected by user (or automatically), it is a 2x3
%		matrix, such that each COLUMN is a point indicating a corner of the target
%		in the first image. Let [p1 p2 p3] be the three points, they are
%		used to determine the affine parameters of the target, as following
% 			  p1(128,116)-------------------p3(120,129)
% 					\						  \
% 					 \			target         \
% 					  \					        \
% 				  p2(150, 136)-------------------\


% %-One can also cropping the initial box through the following code
% init_pos	= SelectTarget(s_frames{1});

init_pos	= [	128 150 120;
			    116 136 129];

%% L1 tracking
fcdatapts       = [28 507; 82 721]; %the coordinates of the image on the figure
tracking_res    = L1Tracking_release( s_frames, sz_T, n_sample, init_pos, res_path, fcdatapts);


%% Output tracking results
for t = 1:nframes
    img_color	= imread(s_frames{t});
    img_color	= double(img_color);
    imshow(uint8(img_color));
    color = [1 0 0];
    map_afnv	= tracking_res(:,t)';
    drawAffine(map_afnv, sz_T, color, 2);
    
    s_res	= s_frames{t}(1:end-4);
    s_res	= fliplr(strtok(fliplr(s_res),'/'));
    s_res	= fliplr(strtok(fliplr(s_res),'\'));
    s_res	= [res_path s_res '_L1.png'];
    f = getframe(gcf);
    % imwrite(uint8(f.cdata(fcdatapts(1,1):fcdatapts(1,2), fcdatapts(2,1):fcdatapts(2,2), :)), s_res);
end

%% output result
s_res = sprintf('%s\\L1_result_%d_%d.mat', res_path, start_frame, nframes);
save(s_res, 'tracking_res');
