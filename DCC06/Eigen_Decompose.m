
% Subspace learning ftn.
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006
% Modified by T-K. Kim, 27 Aug 2006 

function [P,D] = Eigen_Decompose(X,opt);
% Input
% X : a data matrix which has images in its columns
% opt=1 : normal, opt=2 : reduced rank
% 
% Output
% P : eigen-vector matrix
% D : eigen-value matrix

[N M] = size(X);

switch(opt)
    case 1
        Corr = X*X'./M;
        [v d] = eig(Corr);
        P = v; 
    case 2
        Corr = X'*X./M;
        [v d] = eig(Corr);
        P = X*v*inv(sqrt(d));
end


[tmp l] = sort(diag(d),'descend');
P = P(:,l);
D = diag(tmp);