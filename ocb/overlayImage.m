function tempI = overlayImage(subs, I)
    [m n] = size(subs);
    if n ~= 3
        error('We should deal with items with 3 columns');
    end
%     tempI = I;
    tempI = padarray(I, [5 5 15], 'both', 'replicate');

    square = 255 * ones(3, 3);
    
    for j = 1 : size(subs, 1)
        tempI(subs(j, 1)-1 : subs(j, 1) + 1, subs(j, 2)-1 : subs(j, 2) + 1, subs(j, 3)) = square;
    end
    
end