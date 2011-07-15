function saveM_asVideo2(moviefile, M)

nd = ndims(M);
fend = size(M, nd);
% filename = inputname(2);
framerate = 22;
aviobj = avifile(moviefile, 'fps', framerate', 'compression', 'none');

if (nd == 3)    
    for i = 1 : fend
        imshow(M(:, :, i), 'border', 'tight');
        pause(1/22);
        frame = getframe(gcf);
        aviobj = addframe(aviobj, frame);
    end
end

aviobj = close(aviobj);