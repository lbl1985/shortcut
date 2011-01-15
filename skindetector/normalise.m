function im2 = normalise(im)

% linear shift + scale
% to fit from 0 to 1

im2 = im - min(min(min(im)));
if (max(max(max(im2))) ~= 0)
    im2 = im2 / max(max(max(im2)));
end