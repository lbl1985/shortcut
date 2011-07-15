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
                % save a movie into a .mat file at the video's orginial
                % location.
                movie2mat(varargin{:});
            else if nargin == 3 && nargout == 1
                    %  going to be movie2var.m
                    varargout{1} = movie2var(varargin{:});
                end
            end
        end        
    end    
end

