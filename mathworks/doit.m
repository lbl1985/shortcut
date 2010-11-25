function doit(varargin)
% test/toolbox/stateflow/coder/rtw/misc/tmisc2('lvlTwoA11')
% For simulation Sanpshot

if nargin > 1
    str1 = varargin{1};
    str2 = varargin{2};
    sub1(str1, str2);
else
    str = varargin{1};
    sub2(str);
end
end


function sub1(str1, str2)

    x = max(strfind(str1, '/'));
    dic = str1(1 : x-1);
    fil = str1(x+1 : end);
    glf(dic);
    fil = sprintf('%s(', fil);
    fil = sprintf('%sstr2)', fil);
    eval(fil);
end

function sub2(str1)
    x = max(strfind(str1, '/'));
    dic = str1(1 : x-1);
    fil = str1(x+1 : end);
    glf(dic);
    eval(fil)
end

        

% For Enums EML
% str3 = sprintf('%s_SIMRTW', str2);
% strrun = sprintf('%s(str3)',str1); 
% eval(strrun);
% 
% str3 = sprintf('%s_CDR', str2);
% strrun = sprintf('%s(str3)',str1); 
% eval(strrun);