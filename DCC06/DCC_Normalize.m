% a sub ftn. of 'Learn_DCC.m'
% Normalize ftn.
%
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006

function P_temp = DCC_Normalize(P,U,dim);
    
M = size(P,2)/dim;
for i=1:M
    p = P(:,(i-1)*dim+1:i*dim);
    a = U'*p;
    [Q R] = qr(a,0);
    
    for j=1:size(Q,2)
        if(Q(:,j)'*a(:,j)<0)
            R(j,:) = -R(j,:);
        end
    end

    p = p*inv(R);
    P_temp(:,(i-1)*dim+1:i*dim) = p;
end
