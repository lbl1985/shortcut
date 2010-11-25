function saveftc_asVideo(moviefile, ftc, I, sub, clipdesc, k, fbeg, fend, framerate)
nd = ndims(ftc);
% filename = inputname(2);
if nargin < 3,      fbeg = 1;               end
if nargin < 4,      fend = 0;               end
if nargin < 5,      framerate = 29;         end
if fend == 0,       fend = size(ftc, nd);     end 
% [m n] = size(ftc);

hue = 0 : (1 / (k - 1)) : 1;
map = hsv2rgb([hue', ones(k, 2)]);
I = overlayImage_withType(sub, I, clipdesc, k);
fmin = min(sub(:, 3)) - 1;
ymax = max(ftc(:));

aviobj = avifile(moviefile, 'fps', framerate, 'compression', 'none');

for i = fbeg : fend
    subplot(1, 2, 1);
    bar(ftc(:, i));
    colormap(map);  colorbar('location', 'SouthOutside')
    xlim([1 k + 1]);   
    ylim ([0 ymax]);
    xlabel('Feature');  ylabel('Count');    title(['Frame: ', num2str(i)]);
    
    subplot(1, 2, 2);
    if (ndims(I) == 3)
        imshow(I(:, :, i + fmin));
    elseif (ndims(I) == 4)
        imshow(I(:, :, :, i + fmin));
    else
        error('I should be dimension 3 or 4');
    end
    
    pause(1/26);
    frame = getframe(gcf);
    aviobj = addframe(aviobj, frame);
end

aviobj = close(aviobj);