function fp(varargin)

if ~isempty(varargin)
    if isequal(varargin{1}, 1)
    set(gcf,'Position', [1180 52 560 420])
    end
else
    if isequal(gcf, 1)
        set(gcf,'Position', [1180 52 560 420])
    else
    h = gcf - 1;
    x = get(h, 'Position');
    set(gcf,'Position', [x(1)+100 52 560 420])
    end
end