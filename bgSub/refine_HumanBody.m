function imgMask = refine_HumanBody(fr_bw, fg)
fg = imfill(fg, 'holes');
[~, threshold] = edge(fg, 'sobel');
fudgeFactor = .5;
BWs = edge(fg,'sobel', threshold * fudgeFactor);

se90 = strel('line', 3, 90); se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
BWdfill = imfill(BWsdil, 'holes');

seD = strel('diamond', 1);
BWfinal = imerode(BWdfill, seD);
BWfinal = imerode(BWfinal, seD);
BWfinal = imerode(BWfinal, seD);

imgMask = double(fr_bw) .* double(BWfinal);

