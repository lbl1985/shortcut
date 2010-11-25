function aviobj = subs_lookup(subs)
nset = size(subs, 4);  
% nset = 1;
aviobj = avifile('subs_lookup.avi', 'fps', 5, 'compression', 'none');
for s = 0 : (nset - 1)
    srcdir = datadir(s);
    dircontent = dir([srcdir '\cuboids_*.mat']);
    filenames = {dircontent.name};  n = length(dircontent);
    % for which video in the database
    for i = 17 : n
        clipfile = ([srcdir '\clip_' filenames{i}(9:end)]);
        clip = load(clipfile);
        I = clip.I;
        m = size(subs(:, :, i, s+1), 1);
        [B IX] = sort(subs(:, 3, i, s+1));
        sub_sorted = subs(IX, :, i, s+1);
        for j = 1 : m
            % Sort the subs in increase order of frame #. But this makes we
            % can not keep subs order the same as cuboids. But for our
            % lookup purpose, it doesn't matter too much.

%             overlayImage(subs(j, :, i, s+1), I);
            overlayImage(sub_sorted(j, :), I);
%             disp(['s = ' num2str(s)]);
%             disp(['i = ' num2str(i)]);
%             disp(['j = ' num2str(j)]);
            
            str = sprintf('set%s  %s  Frame %d', int2str2(s, 2), ...
                filenames{i}(9:end-4), sub_sorted(j, 3));
            title(str);
            pause(1/26);
            frame = getframe(gcf);
            aviobj = addframe(aviobj, frame);
%             title(['Dataset set' int2str2(s, 2) '\n'...
%                 'Video: ' filenames{i}(9:end-4) '\n'...
%                 'Frame: ' num2str(sub_sorted(j, 3, i, s + 1))]);
        end
    end
end
aviobj = close(aviobj);
close all;




function overlayImage(sub, I)
[m n] = size(sub);
if m ~= 1 || n ~= 3
    error('We can only select one item once');
end
tempI = I;
nFrame = size(I, 3);
% Bcz, our square will be size of 3 x 3.Then we need size(I, n) - 1 stuff.
if sub(1) >= size(I, 1), sub(1) = size(I, 1) - 3; end
if sub(2) >= size(I, 2), sub(2) = size(I, 2) - 3; end
if sub(3) > nFrame,     sub(3) = nFrame; end

tempI = tempI(:, :, sub(3));
square = 255 * ones(3, 3);
tempI(sub(1)-1 : sub(1) + 1, sub(2)-1 : sub(2) + 1) = square;

imshow(tempI, 'Border', 'loose');
        
        
        