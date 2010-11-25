function I = read_frame(varargin)
% filename = varargin{1};
% frame = varargin{2};
% if nargin == 3
%     out_filename = varargin{3};
% end

filename = varargin{1};
if nargin == 2
    frame = varargin{2};
else
    movie = mmreader(filename);
    num = get(movie, 'numberOfFrames');
    frame = round(num /2);
end
if nargin == 3
    out_filename = varargin{3};
else
    out_filename = [filename(1 : end - 4) '.jpg'];
end
movie = mmreader(filename);
% numFrames = get(movie, 'numberOfFrames');
vidFrame = read(movie, [frame frame + 1]);
I = vidFrame(:, :, :, 1);
if nargin ==3 || nargin == 1
    imwrite(I, out_filename);
end
