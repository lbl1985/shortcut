function Rsdetect(nsets, sigma, tau)
% This function is mainly used for detect the R matrix and change it into a
% normalized R. Then save R and R_normal into a same .mat file. Named R_
% clipname .mat

%    INPUT: nsets ---- Number of datasets
%           sigma ---- sigma for stfeatures detection
%           tau   ---- tau   for Garbor filter
%    OUTPUT:NONE  ---- save the results in the same folder as source data

% Time Stamp: 8:40AM  02/Nov/2009
% Binlong Li Version 0.01;


for i = 1 : nsets
    [srcdir filenames n] = rfdatabase(datadir(i - 1), 'clip');
    ticstatusid = ticstatus('Rsdetect',[],49);
    for j = 1 : n
        load([srcdir filenames{j}]);
        R = stfeatures_periodic( double(I)/255 * 2 - 1, sigma, tau);
        R_normal = R / max(R(:));
        destname = [srcdir 'R_' clipname '.mat'];
        savefields = {'R', 'R_normal'};
        save(destname, savefields{:});
        tocstatus( ticstatusid, j/n );
    end
end