function ftc2surf(ftc)
% This function is just used for visualize the ftc by using surf function
% Example: 
% ftc2surf(ftcSdesc{1}{2})

[f t] = size(ftc);
[X Y] = meshgrid(1 : t, 1 : f);
surf(X, Y, ftc);
colormap hsv
xlim([1 t]);    ylim([1 f]);    
% zlim([1 400]);
xlabel('# of Frame');    ylabel('# of Feature');    zlabel('Count');