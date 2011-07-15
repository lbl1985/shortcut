classdef video
    %VIDEO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        videoName = '';
        videoPath = '';        
    end
    
    methods (Static)
        function varargout = movie2mat(varargin)
            if nargin == 1 && nargout == 0
                % original movie2mat.m function
                video = mmread(filename);
                n = length(video.frames);
                mat = zeros(video.height, video.width ,3, n);
                for i = 1 : n
                    mat(:, :, :, i) = video.frames(i).cdata;
                end
                save mat mat
            else if nargin == 2 && varargout == 1
                    
            end
        end
        
    end
    
end

