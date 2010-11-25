% function [ImageIndex pCamera] = TestProg(M, ext_para, X, Y, Z)
function [ImageIndex pCamera] = TestProg(M, ext_para, pVicon)
if size(pVicon, 1) == 1 || size(pVicon, 2) == 1    
    pVicon = pVicon';
    pWorld = [pVicon(1 : 2); pVicon(3) + 52.7; 1];
    % pWorld = [X; Y; Z + 52.7; 1];
    pCamera = ext_para * pWorld;
    ImageIndex = M * pCamera(1:3) ./ pCamera(3);
    % Zdist = pCamera(3);
else
    pVicon = pVicon';
    pWorld = [pVicon(1:2, :); pVicon(3, :) + 52.7; ones(1, size(pVicon, 2))];
    pCamera = ext_para * pWorld;
    ImageIndex = M * pCamera(1:3, :);
    ImageIndex = (ImageIndex .* repmat(ImageIndex(end, :) .\ 1, size(ImageIndex, 1), 1))';
    ImageIndex = round(ImageIndex(:, 1 : 2));
    
%     pWorld = 
    
end