function  FrameFeaturesBatch  = FrameFeatureExtractionFromHankel(HankelMatrixBatch, Fdim, HWS)
% load all_actions.mat;
% Fdim: Feature Dimension
% HWS: HankelWindowSize
D = length(HankelMatrixBatch);
FrameFeaturesBatch = cell(D, 1);

for i = 1 : D
    thankel = HankelMatrixBatch{i};
    LenHankel = size(thankel, 2);
    tFF = zeros(Fdim, HWS + LenHankel - 1);
    tFF(:, 1 : HWS) = reshape(thankel(:, 1), Fdim, HWS);
    for j = 2 : LenHankel
        tFF(:, HWS + j - 1) = thankel(end - Fdim + 1 : end, j);
    end
    FrameFeaturesBatch{i} = tFF;
end


% 
% for ActionNum = 1 : 4
%     for ClipNum = 1 : 100
%         Idx = (ActionNum - 1) * 100 + ClipNum;
%         tFF = zeros(12, 30);
%         thankel = HankelMatrixBatch{Idx};
%         tFF(:, 1 : 3) = reshape(thankel(:, 1), 12, 3);
%         for i = 4 : 30
%             tFF(:, i) = thankel(end - (12 - 1) : end, i - 2);
%         end
%         FrameFeaturesBatch{(ActionNum - 1) * 100 + ClipNum} = tFF;
%     end
% end