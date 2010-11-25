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

function dir = datadir( set_ind, varargin )

    % root directory
    %dir = 'C:/code/mice/data';
    %dir = 'C:/code/faces/data';
    % dir = 'C:\code\cuboids\face_data';
    
    if ispc        
        endsign = '\';
    else
        workingpath = '/media/A642E42A42E3FD45/Users/Binlong/Documents/MATLAB/work';
        endsign = '/';
    end
    
    if isempty(varargin)
        dir = [workingpath 'SELF_KTH\ForeGroundData'];
    else        
        switch varargin{1}
            case 'BoundingBox'
                dir = fullfile(workingpath, 'SELF_KTH', 'dataResult', 'BoundingBox');
            case 'ResizeBox'
                dir = fullfile(workingpath, 'SELF_KTH', 'dataResult', 'ResizeBox');
            case 'kthdata2'
                dir = fullfile(workingpath, 'database', 'kth');
            case 'kth_selectFrames'
                dir = fullfile(workingpath, 'database', 'kth_selectFrames');
            case 'kthForeGround'
                dir = fullfile(workingpath, 'BR', 'cuboids_trial', 'KTH', 'ForeGroundData');
            case 'kthForeGround2'
                dir = fullfile(workingpath, 'BR', 'cuboids_trial', 'KTH', 'ForeGroundData2');
            case 'kthBoundingBox'
%                 dir = [workingpath 'BR\cuboids_trial\KTH\dataResult\BoundingBox\'];
                dir = fullfile(workingpath, 'self_kth_idea', 'BoundingBox');                
            case 'kthBoundingBox2'
                dir = fullfile(workingpath, 'BR', 'cuboids_trial', 'KTH', 'dataResult2', 'BoundingBox');
            case 'kthResizeBox'
                dir = fullfile(workingpath, 'BR', 'cuboids_trial', 'KTH', 'dataResult', 'ResizeBox');
            case 'kthResizeBox2'
                dir = fullfile(workingpath, 'BR', 'cuboids_trial', 'KTH', 'dataResult2', 'ResizeBox');
        end
        dir = [dir endsign];
    end
%     dir = 'C:\Users\lbl1985\Documents\MATLAB\work\BR\cuboids_trial\recognition\mouse';
    
    

    % set index
    if( nargin==0 ) return; end;
    switch num2str(set_ind)
        case '0'
            dir = [dir 'boxing'];
        case '1'
            dir = [dir 'handclapping'];
        case '3'
            dir = [dir 'walking'];
        case '4'
            dir = [dir 'running'];
        case '2'
            dir = [dir 'handwaving'];
        case '5'
            dir = [dir 'jogging'];
    end
    dir = [dir endsign];
    
