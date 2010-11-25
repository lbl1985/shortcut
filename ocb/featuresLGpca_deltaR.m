% Dimensionality reduction for cuboids descriptors.
%
% Assumes feature extraction (FEATURESLGDETECT) has been run.  
% See FEATURESSMPCA for more info. 
%
% INPUTS
%   nsets       - number of sets
%   ncuboids    - number of cuboids to grab per .mat file
%   cubdesc     - cuboid descriptor [see imagedesc_getpca]
%   kpca        - number of dimensions to reduce data to [see imagedesc_getpca]
%   
% OUTPUTS
%   cubdec      - cuboid descriptor with pca info [see imagedesc_getpca]
%   cuboids     - sampled cuboids 
%
% See also FEATURESLG, FEATURESSMPCA, FEATURESLGDETECT

function [cubdesc,cuboids] = featuresLGpca_deltaR( nsets, ncuboids, cubdesc, kpca  )

    %%% sample cuboids from each dataset
    cuboids=[];
    for s=0:(nsets-1)
        srcdir = datadir(s);
        matcontents = {'clipname','cliptype','cuboids','subs'};
        cuboids_all = feval_mats( @featuresLGpca1, matcontents, {ncuboids}, srcdir, 'cuboids' );
        cuboids_all = permute( cuboids_all, [1 3 4 2] );
        cuboids = cat(4,cuboids,cell2mat( cuboids_all ));
    end;

    % getpca
    cubdesc = imagedesc_getpca( cuboids, cubdesc, kpca, 0 );

    
function x = featuresLGpca1( vals, params ) 
    [clipname,cliptype,cuboids, subs] = deal( vals{:} );
    ncuboids = deal( params{:} );
    
    n = size(cuboids,4);
    srcdir = evalin('caller', 'srcdir');
    load([srcdir 'rankM_' clipname '.mat']);
    [B IX] = sort(R, 'descend');
    if( n>ncuboids ) 
%         h = selection([], [srcdir 'clip_' clipname '.mat'], subs, cuboids, ncuboids);
%         uiwait(h);
%         cuboids = evalin('base', 'cuboids_slt');  evalin('base', 'clear cuboids_slt');
%         cuboids = cuboids( :,:,:, randperm2(n,ncuboids) );
        cuboids = cuboids( :,:,:, IX(1: ncuboids) );
        subs = subs(IX(1:ncuboids), :);
    end

    destname = [srcdir 'selcub_' clipname '.mat'];
    save(destname, 'cuboids', 'subs', 'clipname', 'cliptype');
    x = {cuboids};
