function [clipSdesc ftcSdesc]= codebook2clipsdesc_w(DATASETS, clusters)
reqfs = {'nclips', 'desc', 'subs'};
if (~isfield2(DATASETS, reqfs, 1))
    ermsg = []; 
    for i = 1 : length(reqfs)
        ermsg = [ermsg reqfs{i} ', ']; 
    end
    error(['Each DATASET must have: ' ermsg 'initialized']);
end

%%% assign cuboids to clusters and creat descriptor for each clip in DATASET
k = size(clusters, 1);
nsets = length(DATASETS);
nclips = cell2mat({DATASETS.nclips});   
clipSdesc = cell(nsets, 1); ftcSdesc = cell(nsets, 1);
for i = 1 : nsets
    % Save all of the cuboids belongs to which cluster information for
    % nclips(i) video in each dataset.
    clipdesc = cell(nclips(i), 1);
    ftcdesc = cell(nclips(i), 1);
    [srcdir filenames n] = rfdatabase(datadir(i - 1), 'rankM');    
    for j = 1 : nclips(i)
        % desclust with size #cuboids x 1; with the information about which
        % cluster it should be for each cuboid.
        load([srcdir filenames{j}]); clear M;
        desclust = imagedesc2clusters(DATASETS(i).desc{j}, clusters);        
        ftc = clipsdesc2ftc_w(DATASETS(i).subs{j}, desclust, k, R);
        clipdesc{j} = desclust;
        ftcdesc{j} = ftc;
    end
    clipSdesc{i} = clipdesc;
    ftcSdesc{i} = ftcdesc;
end