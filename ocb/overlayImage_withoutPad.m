function tempI = overlayImage_withoutPad(subs, I)
    [m n] = size(subs);
    if n ~= 3
        error('We should deal with items with 3 columns');
    end
    tempI = I;
%     tempI = padarray(I, [5 5 15], 'both', 'replicate');
    if ~isa(tempI, 'uint8')
        tempI = uint8(I);
    end

    square = uint8(255 * ones(3, 3));
    
    for j = 1 : size(subs, 1)
        disp(['j=' num2str(j)]);
        if subs(j, 2) < 2
            subs(j, 2) = 2;
        end
        if subs(j, 1) < 2
            subs(j, 1) = 2;
        end
        
        tempI(subs(j, 1)-1 : subs(j, 1) + 1, subs(j, 2)-1 : subs(j, 2) + 1, subs(j, 3)) = square;
    end
    
end