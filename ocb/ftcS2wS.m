function wS = ftcS2wS(ftcSdesc)

wS = cell(size(ftcSdesc));
for i = 1 : size(ftcSdesc, 1)
    w = cell(size(ftcSdesc{i}));
    for j = 1 : size(ftcSdesc{i}, 1)
        [B IX] = sort(ftcSdesc{i}{j}, 'descend');
        w{j} = IX(1:3, :);
    end
    wS{i} = w;
end
        
