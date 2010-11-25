function BlueScreen = blueScreen(I, BoundingBox, varargin)
% Putting the foreGround Image into the Center (mode) of the 
if isempty(varargin)
    mode = 'Center';
else
    mode = varargin{1};
end
switch mode
    case 'Center'
        [m n z] = size(I); BlueScreen = zeros(size(I));
        for i = 1 : z
            lefttop = BoundingBox(i, 1 : 2); rightbottom = BoundingBox(i, 3 : 4);
            BlueScreen(:, :, i) = blueScreenPerFrame(I(lefttop(1) : rightbottom(1), ...
                lefttop(2) : rightbottom(2), i), [m n]);
        end
    case 'extend'
        ext = 15; Ibg = median(I, 3); 
        [m n z] = size(I); BlueScreen = repmat(Ibg, [1 1 z]);
        for i = 1 : z
            lefttop = BoundingBox(i, 1 : 2); rightbottom = BoundingBox(i, 3 : 4);
            lefttop = lefttop - ext; rightbottom = rightbottom + ext;
            [lefttop rightbottom] = borderPixelPointAdjust(lefttop, rightbottom, [m n]);
            try
            BlueScreen(:, :, i) = blueScreenPerFrame(I(lefttop(1) : rightbottom(1), ...
                lefttop(2) : rightbottom(2), i), [m n], Ibg);
            catch
                display(['i = ' num2str(i)]);
            end
        end
end

function BlueScreenPerFrame = blueScreenPerFrame(foreGround, siz, varargin)
if ~isempty(varargin)
    Ibg = varargin{1};
    BlueScreenPerFrame = Ibg;
else
    BlueScreenPerFrame = zeros(siz);
end
[m n] = size(foreGround);
lefttop = floor((siz - [m n]) / 2) + 1;
BlueScreenPerFrame(lefttop(1) : lefttop(1) + m - 1 , lefttop(2) : lefttop(2) + n - 1) ...
    = foreGround;

function [lefttop rightbottom] = borderPixelPointAdjust(lefttop, rightbottom, siz)
% elements in lefttop < 1, assign it to be 1. larger than m assign it to be
% m;
% elements in rightbottom < 1, assign it to be 1. larger than n assign it
% to be n.
borderPixelPoints = [lefttop rightbottom];
for i = 1 : length(borderPixelPoints)
    if borderPixelPoints(i) < 1
        borderPixelPoints(i) = 1;
    end
    if mod(i, 2) == 1
        if borderPixelPoints(i) > siz(1)
            borderPixelPoints(i) = siz(1);
        end
    else
        if borderPixelPoints(i) > siz(2)
            borderPixelPoints(i) = siz(2);
        end
    end
end
lefttop = borderPixelPoints(1: 2); rightbottom = borderPixelPoints(3 : 4);