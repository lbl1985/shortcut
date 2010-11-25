function [clipdesc ftc] = runone(Type, clip, cubdesc_new, clusters, k)
thr = 0;
par_stfeatures = {2, 3, 1, thr, [], 1.85, 1, 1, 0};
[srcdir filenames n] = rfdatabase(datadir(Type - 1), 'clip');
filename = filenames{clip};
load([srcdir '\' filename]);

I_pad = padarray(I, [5 5 15], 'both', 'replicate');
[R,subs,vals,cuboids,V] = stfeatures_onlyS( I_pad, par_stfeatures{:} );
desc = imagedesc(cuboids, cubdesc_new);

clipdesc = imagedesc2clusters(desc, clusters);
ftc = clipsdesc2ftc(subs, clipdesc, k);

savefields = {'I', 'clipname', 'cliptype', 'cuboids', 'subs', 'R', 'desc',...
    'clipdesc', 'ftc'};
destname = [resultdir(250) '\DATASETS_ALL_Type' num2str(Type) 'Clip' num2str(clip) '_onlyS'];
% save(destname, savefields{:});
save(destname);

saveftc_asVideo([resultdir(250) '\trial_cb250_onlyS.avi'], ftc, I, subs, clipdesc, k, 1, 0, 3);