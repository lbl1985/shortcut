function movie = diffBackgroundSub(I)
thresh = 45;
bg_bw = I(:, :,1);

n = size(I, 3);
matlabpool open
parfor i = 2 : n
    fr_bw = I(:, :, i);
    fr_diff = abs(double(fr_bw) - double(bg_bw));  % cast operands as double to avoid negative overflow
    
    fg_mask = fr_diff > thresh; 
    fg = uint8(double(fr_bw) .* double(fg_mask));

    fg = refine_HumanBody(fr_bw, fg);
    
    movie(:, :, i) = fg; 
    disp(['Frame ' num2str(i)]); 
end
matlabpool close 