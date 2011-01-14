% generate templates from single image
function [crop,crop_norm,crop_mean,crop_std] = genTemplatesFromSingleImage(tsize,sfno,fprefix,fext,illumination,cpt,numzeros)
%   (r1,c1) ***** (r3,c3)            (1,1) ***** (1,cols)
%     *             *                  *           *
%      *             *       ----->     *           *
%       *             *                  *           *
%     (r2,c2) ***** (r4,c4)              (rows,1) **** (rows,cols)
% r1,r2,r3;
% c1,c2,c3

p{1}= cpt;
p{2} = cpt + [-1 0 0; 0 0 0];
p{3} = cpt + [1 0 0; 0 0 0];
p{4} = cpt + [0 -1 0; 0 0 0];
p{5} = cpt + [0 1 0; 0 0 0];
p{6} = cpt + [0 0 1; 0 0 0];
p{7} = cpt + [0 0 0; -1 0 0];
p{8} = cpt + [0 0 0; 1 0 0];
p{9} = cpt + [0 0 0; 0 -1 0];
p{10} = cpt + [0 0 0; 0 1 0];

crop = zeros(prod(tsize),10);
nz=strcat('%0',num2str(numzeros),'d');

for n=1:10
    image_no = sfno;
    fid = sprintf(nz, image_no);
    img_name = strcat(fprefix,fid,'.',fext);
    
    img = imread(img_name);
    img = rgb2gray(img);
    img = double(img);
    [crop(:,n),crop_norm(n),crop_mean(n),crop_std(n)] = corner2image(img, p{n}, tsize, illumination);   
end