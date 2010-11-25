function info = readSTIP(fileName)
% This file is used in MAC Machine. Not tested on a Windows Machine.

fid = fopen(fileName);
for i = 1 : 3
    tline = fgetl(fid);
end

FeaturePoint = []; FilterPara = []; Conf = []; STIPVector = [];
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    tlineNum = str2num(tline);
    FeaturePoint = cat(1, FeaturePoint, tlineNum(2 : 4));
    FilterPara = cat(1, FilterPara, tlineNum(5 : 6));
    Conf = cat(1, Conf, tlineNum(7));
    STIPVector = cat(1, STIPVector, tlineNum(10 : end));
end
[~, IX] = sort(FeaturePoint(:, 3));
FeaturePoint = FeaturePoint(IX, :);
FilterPara = FilterPara(IX, :);
Conf = Conf(IX, :);
STIPVector = STIPVector(IX, :);

info.FeaturePoint = FeaturePoint;
info.FilterPara = FilterPara;
info.Conf = Conf;
info.STIPVector = STIPVector;