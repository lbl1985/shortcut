% Unit comparison ftn. by discriminative canonical correlations
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006
% Modified by T-K. Kim, 27 Aug 2006 

function score = Compare_By_DCC(Ptr,P,T,ang_dim); 

P1 = Ptr;
P2 = P;
dim = size(P,2); 

P1 = T'*P1; [Qc tmp] = qr(P1,0); P1 = Qc(:,1:dim);
P2 = T'*P2; [Qc tmp] = qr(P2,0); P2 = Qc(:,1:dim);
      
[Q1 C Q2] = svd(P1'*P2);
score = mean(diag(C(1:ang_dim,1:ang_dim)));
   
  
        

