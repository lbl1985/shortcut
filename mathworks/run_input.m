function run_input(str1, str2)
    varargin = eval(str2);
    temp_in = '';
    temp = '';
    for i = 1 : length(varargin)
        temp_in = sprintf('in%d', i);
        temp_in = sprintf('%s = varargin{i}',temp_in);        
    end
    temp_in = sprintf('%s;', temp_in);
    eval(temp_in);
    
    for i = 1 : length(varargin)
        if (i == 1)
            temp = sprintf('%s(varargin{%d}', str1, i);
        else
            temp = sprintf('%s, varargin{%d}', temp, i);
        end
    end
    temp = sprintf('%s);', temp);
    eval(temp);
    
end