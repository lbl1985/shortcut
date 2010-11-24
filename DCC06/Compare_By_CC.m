% Unit comparison ftn. by canonical correlations
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006
% Modified by T-K. Kim, 27 Aug 2006 

function score = Compare_By_CC(Ptr,P,ang_dim); 

dim = size(P,2); 
[Y C Z] = svd(Ptr'*P);
score = mean(diag(C(1:ang_dim,1:ang_dim)));
   
  
        

