function flattenMatrix(M)
    n = ndims(M);
    siz = size(M, n);
    ncol = 5;
    nrow = floor(siz/ncol) + 1;
    if(n == 3)        
        for i = 1 : siz
            subplot(nrow, ncol, i); imshow(M(:, :, i));
%             s = sprintf('Frame%d', i);
%             title(s);
        end
    elseif (n == 4)
        for i = 1 : siz
            subplot(nrow, ncol, i); imshow(M(:, :, :, i));
        end
    end