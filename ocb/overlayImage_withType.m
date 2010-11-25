function tempI = overlayImage_withType(subs, I, clipdesc, k)
    [m n] = size(subs);
    if n ~= 3
        error('We should deal with items with 3 columns');
    end
    I = uint8(I);
%     tempI = I;
    tempI = padarray(I, [5 5 15], 'both', 'replicate');
    
    tempI = permute(tempI, [3 1 2]);
    tempI = repmat(tempI, [1 1 1 3]);
    tempI = permute(tempI, [2 3 4 1]);
    
%     hue = 1 : (255 / (k )) : 255;
    hue = 0:(1/(k-1)):1;

%     square = 255 * ones(3, 3);
    
    for j = 1 : size(subs, 1)
        tempI(subs(j, 1)-1 : subs(j, 1) + 1, subs(j, 2)-1 : subs(j, 2) + 1,...
            :, subs(j, 3)) = uint8(repmat(permute(255 * hsv2rgb([hue(clipdesc(j)), 1 1]), [ 3 1 2]), [3 3]));
    end
    
end