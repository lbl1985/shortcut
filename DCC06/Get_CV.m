% a sub ftn. of 'Learn_DCC.m'
% Ftn. to compute canonical vectors
%
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006

function [can1 can2] = Get_CV(T,V_tr,V_te)
% 
% KK=(T'*V_tr)'*(T'*V_te);
% if(min(size(KK))>5)
%     55;
% end
[Y ,C, Z] = svd((V_tr'*(T*T')*V_te));
can1 = V_tr*Y;
can2 = V_te*Z;

% KK=(T'*V_tr)'*(T'*V_te);
% 
% if(min(size(KK))>10)
%     55;
% end
% [Y C Z] = svds(KK,min(size(KK)));
% can1 = V_tr*Y;
% can2 = V_te*Z;