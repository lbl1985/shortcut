function aviobj = confmatrix_show_CMS(CMS, cliptypes)
% This is just the help function for BR, which can show the results of the
% CMS matrix, which is the accounting matrix for the label classes. We can
% not only obtain the CMS as a matrix table show video, we can also obtain
% a overall matrix figure. 

% Example:
% load CMS.mat
% confmatrix_show_CMS(CMS, cliptypes);
show = 1;
figure(show);
m = size(CMS, 3); n = size(CMS, 4);
aviobj = avifile('facial_set_CMS.avi', 'fps', 2, 'compression', 'none');
for i = 1 : m
    for j = 1 : n
%         figure(show); show = show + 1;
        confmatrix_show( CMS(:,:,i,j), cliptypes );
        msg = ['training set ' num2str(i) ' testing set ' num2str(j)];
        title(msg);        
        frame = getframe(gcf);
        aviobj = addframe(aviobj, frame);
    end
end
aviobj = close(aviobj);
close all;

% Because the CMS is for training set i to test set j. 
% However we need a general matrix to denote the overall effort of the
% classification.
g = figure; CMS_total = sum(sum(CMS, 3), 4);
confmatrix_show(CMS_total, cliptypes);
title('The all added up CMS');
saveas(g, 'overall_CMS.fig');