% Get location of data; alter file depending on location of dataset.
%
% INPUTS
%   set_ind     - [optional] set index, value between 0 and nsets-1
%
% OUTPUTS
%   dir         - final directory
%
% EXAMPLE
%   dir = getclipsdir( 'mouse00', 'features' )

function dir = datadir_interaction( set_ind, varargin )

% root directory
%dir = 'C:/code/mice/data';
%dir = 'C:/code/faces/data';
% dir = 'C:\code\cuboids\face_data';
%     [status ComputerName] = system('hostName'); clear status;
ComputerName = getComputerName();
% classes = 7; for special Settings. Boxing Waving walking Running.
switch deblank(ComputerName)
    case 'lbl1985-pc'
        workingpath = 'C:\Users\lbl1985\Documents\MATLAB\work\';
    case 'binlong-desktop'
%         workingpath = '/media/A642E42A42E3FD45/Users/Binlong/Documents/MATLAB/work/';
        workingpath = '/home/binlong/Documents/MATLAB/work/';
    case 'XPS-PC'
        workingpath = 'C:\Users\XPS\Documents\MATLAB\work\';
    case 'iMac.local'
        
end


if isempty(varargin)
    dir = fullfile(workingpath, 'database', 'interaction');
else
    switch varargin{1}
        case 'manualTracking'
            dir = fullfile(workingpath, 'interaction', 'manualTracking', 'TrackingResult');
        case 'tvinteraction'
            dir = fullfile(workingpath, 'database', 'tvinteraction', 'tv_human_interactions_videos');
        case 'tvinteractionAnnotation'
            dir = fullfile(workingpath, 'database', 'tvinteraction', 'tv_human_interaction_annotations');
    end
end

%     dir = 'C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\recognition\mouse';



% set index
if( nargin==0 )  dir = dirpostfix(dir); return; end;
switch num2str(set_ind)
    case '0'
        dir = fullfile(dir, 'handShake');
    case '1'
        dir = fullfile(dir, 'highFive');
    case '2'
        dir = fullfile(dir, 'kiss');
    case '3'
        dir = fullfile(dir, 'hug');
    otherwise
        dir = dir;
end
dir = dirpostfix(dir);

