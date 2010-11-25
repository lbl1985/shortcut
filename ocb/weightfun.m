function Xweighted = weightfun(X, w)
% This funtion is going to add the function of weight to the histogram. 
% Input: 
%    X: detected feature types according to frame i(in the caller
%    function)
%    w: the weight according to the features in feature input
% Output:
%    Xweighted: the Time feature with weight in it.
% Example:
% feature = [40; 19; 19; 39;17];
% weight = [3; 5; 2; 8; 0];
% tf_after_weight = weightfun(feature, weight);

if size(X, 1) ~= size(w, 1)
    error('rows of feature and weight should be the same');
end

 c = cumsum([1;w]);
 p = zeros(c(end),1);
 p(c) = 1;
 p = cumsum(p);
 p(end) = [];
 Xweighted = X(p,:);

