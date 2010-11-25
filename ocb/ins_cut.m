function ins_cut(Type, clip, frame)

if size(frame, 2) ~= 2
    error([inputname(3) ' should have 2 columns']);
end

% For I, clip_*.mat
[srcdir filenames n] = rfdatabase(datadir(Type - 1), 'clip');
filename = filenames{clip}; filename_o = filename;  % where the 'o' means original.
load([srcdir filename]);
I = I(:, :, frame(1) : frame(2));
savefields = {'I', 'clipname', 'cliptype'};
save([srcdir filename], savefields{:}); clear(savefields{:});

filename = ['R' filename_o(5: end)];
load([srcdir filename]);
R = R(:, :, frame(1) : frame(2));
R_normal = R_normal(:, :, frame(1) : frame(2));
savefields = {'R', 'R_normal'};
save([srcdir filename], savefields{:}); clear(savefields{:});

filename = ['cuboids' filename_o(5: end)];
load([srcdir filename]);
ix = (subs(:, 3) >= frame(1) & subs(:, 3) <= frame(2));
subs = subs(ix, :);
cuboids = cuboids(:, :, :, ix);
savefields = {'cuboids', 'subs', 'clipname', 'cliptype'};
save([srcdir filename], savefields{:}); clear(savefields{:});

filename = ['features' filename_o(5: end)];
load([srcdir filename]);
ix = (subs(:, 3) >= frame(1) & subs(:, 3) <= frame(2));
subs = subs(ix, :);
desc = desc(ix, :);
savefields = {'desc', 'subs', 'clipname', 'cliptype'};
save([srcdir filename], savefields{:}); clear(savefields{:});

filename = ['rankM' filename_o(5: end)];
load([srcdir filename]);
M = M{ix, :};
R = R(ix, :);
savefields = {'M', 'R'};
save([srcdir filename], savefields{:}); clear(savefields{:});


