function [track_res] = L1Tracking_release( s_frames, sz_T, n_sample, init_pos, ...
    s_debug_path,  fcdatapts)
% L1Tracking  Visual tracking using L1-regularized least square.
%	[track_res] = L1Tracking( s_frames, sz_T, n_sample, init_pos )
%	tracks a target defined by the user using 'init_pos'
%
% Input:
%	s_frames	- names of sequence images to be tracked.
%	sz_T		- template size, e.g. 12 x 15
%	init_pos	- target selected by user (or automatically), it is a 2x3
%		matrix, such that each COLUMN is a point indicating a corner of the target
%		in the first image. Let [p1 p2 p3] be the three points, they are
%		used to determine the affine parameters of the target, as following
% 			  p1-------------------p3
% 				\					\
% 				 \       target      \
% 				  \                   \
% 				  p2-------------------\
%
% Output:
%	track_res - a 6xN matrix where each column contains the six affine parameters
%		for the corresponding frame, where N is the number of frames.
%
% For more details, refer to
%		X. Mei and H. Ling, Robust Visual Tracking using L1 Minimization,
%		IEEE International Conference on Computer Vision (ICCV), Kyoto, Japan, 2009.
%
% Xue Mei and Haibin Ling, Oct. 2009

%% Initialize T
%-Generate T from single image
nT			= 10;		% number of templates used, fixed in this version
img_name	= s_frames{1};
[T,T_norm,T_mean,T_std] = InitTemplates(sz_T,img_name,init_pos);

norms = T_norm.*T_std; %template norms

%% L1 function settings
lambda	= .01;
rel_tol = 0.01;
quiet	= true;

dim_T	= size(T,1);	%number of elements in one template, sz_T(1)*sz_T(2)=12x15 = 180
A		= [T eye(dim_T)]; %data matrix is composed of T, positive trivial T.
alpha = 30;
aff_obj = corners2afnv(init_pos, sz_T); %get affine transformation parameters from the corner points in the first frame
map_aff = aff_obj.afnv;
aff_samples = ones(n_sample,1)*map_aff;
rel_std_afnv = [0.005,0.0005,0.0005,0.005,1,1];
W = [1 1 1 1 1 1 1 1 1 1]; %W are initialized to
T_id	= -(1:10);	% template IDs, for debugging
fixT = T(:,1)/nT; % first template is used as a fixed template

%% Tracking
nframes	= length(s_frames);
track_res	= zeros(6,nframes);
for t = 1:nframes
    fprintf('Frame number: %d \n',t); %image_no);
    
    img_color	= imread(s_frames{t});
    if(size(img_color,3) == 3)
        img     = double(rgb2gray(img_color));
    else
        img     = double(img_color);
    end
    %-Draw transformation samples from a Gaussian distribution
    sc			= sqrt(sum(map_aff(1:4).^2)/2);
    std_aff		= rel_std_afnv.*[1, sc, sc, 1, sc, sc];
    map_aff		= map_aff + 1e-14;
    aff_samples = Seg_draw_sample(aff_samples, std_aff); %draw transformation samples from a Gaussian distribution
    
    %-Crop candidate targets "Y" according to the transformation samples
    [Y, Y_inrange] = Seg_gly_crop(img, aff_samples(:,1:6), sz_T);
    if(sum(Y_inrange==0) == n_sample)
        sprintf('Target is out of the frame!\n');
    end
    
    [Y,Y_crop_mean,Y_crop_std] = gly_zmuv(Y);	 % zero-mean-unit-variance
    [Y, Y_crop_norm] = normalizeTemplates(Y);
    
    %-L1-LS for each candidate target
    eta_max	= -inf;
    eta_1	= zeros(n_sample,1);
    
    for i=1:n_sample
        % ignore the out-of-frame image patch and constant image patch
        if(Y_inrange(i) == 0 || sum(abs(Y(:,i))) == 0)
            continue;
        end
        param.lambda = 0.01;
        param.lambda2 = 0;
        param.mode = 2;
        param.L = length(Y(:,i));
        c = mexLasso(Y(:,i), [A fixT], param);
        c = full(c);
 
        D_s = (Y(:,i) - [A(:,1:nT) fixT]*[c(1:nT); c(end)]).^2;
        eta_1(i) = exp(-alpha*sqrt(sum(D_s)));
      
        if(sum(c(1:nT))<0) %remove the inverse intensity patterns
            continue;
        elseif(eta_1(i)>eta_max)
            id_max	= i;
            c_max	= c;
            eta_max = eta_1(i);
        end
    end
    
    %id_max	= find_max_no(eta_1);
    map_aff = aff_samples(id_max,1:6); %target transformation parameters with the maximum probability
    a_max	= c_max(1:nT);
    [aff_samples, count] = Seg_resample(aff_samples, eta_1, map_aff); %resample the samples wrt. the probability
    [maxA, indA] = max(a_max);
    min_angle = images_angle(Y(:,id_max),A(:,indA));
    
    %-Template update
    W = W.*exp(a_max)';
    if( min_angle > 60 )
        % find the tempalte to be replaced
        [temp,indW] = min(W);
        W(indW)		= 0;
        W(indW)		= median(W);
        
        % insert new template
        T(:,indW)	= Y(:,id_max);
        T_mean(indW)= Y_crop_mean(id_max);
        T_id(indW)	= t; %track the replaced template for debugging
        norms(indW) = Y_crop_std(id_max)*Y_crop_norm(id_max);
    end
    W			= normalizeWeights(W, 1); %remove it maybe
    [T, T_norm] = normalizeTemplates(T);
    T			= T.*(ones(dim_T,1)*W);
    A(:,1:nT)	= T;
    norms		= norms.*T_norm./W;
    
    %-Store tracking result
    track_res(:,t) = map_aff';
    
    %-Demostration and debugging
    if exist('s_debug_path', 'var')
        % print debugging information
        fprintf('minimum angle: %f\n', min_angle);
        fprintf('T are: ');
        for i = 1:nT
            fprintf('%d ',T_id(i));
        end
        fprintf('\n');
        fprintf('coffs are: ');
        for i = 1:nT
            fprintf('%.3f ',c_max(i));
        end
        fprintf('\n');
        fprintf('W are: ');
        for i = 1:nT
            fprintf('%.3f ',W(i));
        end
        fprintf('\n\n');
        
        % draw tracking results
        img_color	= double(img_color);
        img_color	= showTemplates(img_color, T, T_mean, norms, sz_T, nT);
        imshow(uint8(img_color));
        text(5,10,num2str(t),'FontSize',18,'Color','r');
        color = [1 0 0];
        drawAffine(map_aff, sz_T, color, 2);
        drawnow;
        
        if ~exist(s_debug_path,'dir')
            fprintf('Path %s not exist!\n', s_debug_path);
        else
            s_res	= s_frames{t}(1:end-4);
            s_res	= fliplr(strtok(fliplr(s_res),'/'));
            s_res	= fliplr(strtok(fliplr(s_res),'\'));
            s_res	= [s_debug_path s_res '_L1.png'];
            f		= getframe(gcf);
            %imwrite(uint8(f.cdata(fcdatapts(1,1):fcdatapts(1,2), fcdatapts(2,1):fcdatapts(2,2), :)), s_res);
        end
    end
end
