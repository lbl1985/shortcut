
% DCC learning ftn.
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 24 Nov 2006

function Tf = Learn_DCC(Pm,num_class,num_sets,pca_dim,dims);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instead of using every pair of image sets in the loop, 
% can use k-NN sets for speeding up !
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fixed param
n_iter = 10; % number of iteration

% Setting param
img_dim = size(Pm,1); u_dim_max = dims; ang_dim = pca_dim;  dim = pca_dim;


if(dims==img_dim) % No dimension reduction
    Porg = Pm;
else
    [P D] = eig(Pm*Pm');
    P = fliplr(P); P = P(:,1:u_dim_max); 
    Porg = P'*Pm;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iterative optimization
T = eye(u_dim_max,u_dim_max); % Init.

for iter=1:n_iter
fprintf('\n iter %d \n',iter);
 
% Step-1: Normalize P
Po = DCC_Normalize(Porg,T,dim);

Sw = zeros(u_dim_max,u_dim_max); Sb = zeros(u_dim_max,u_dim_max);
V1 = zeros(u_dim_max,pca_dim); V2 = zeros(u_dim_max,pca_dim);
    
nw = 0; nb=0;
% Within-class sets
for k=1:num_class
    for set1=1:num_sets
        for set2=set1+1:num_sets
            V1(:,:) = Po(:,(k-1)*num_sets*dim+(set1-1)*dim+1:(k-1)*num_sets*dim+(set1-1)*dim+dim); 
            V2(:,:) = Po(:,(k-1)*num_sets*dim+(set2-1)*dim+1:(k-1)*num_sets*dim+(set2-1)*dim+dim); 
            
            % Step-2: Compute Rotating Matrices Q
            [can1 can2] = Get_CV(T,V1(:,1:dim),V2(:,1:dim));
                    
            dtemp = can1 - can2; 
            Sdtemp = dtemp*dtemp';
            Sw = Sw + Sdtemp; nw = nw+1;
        end
    end
end % End of the loop for the Within-class sets

% Between-class sets
for k=1:num_class
    for j=k+1:num_class
        for set1=1:num_sets
            for set2=1:num_sets
            V1(:,:) = Po(:,(k-1)*num_sets*dim+(set1-1)*dim+1:(k-1)*num_sets*dim+(set1-1)*dim+dim); 
            V2(:,:) = Po(:,(j-1)*num_sets*dim+(set2-1)*dim+1:(j-1)*num_sets*dim+(set2-1)*dim+dim); 
            
            % Step-2 : Compute Rotating Matrices Q
            [can1 can2] = Get_CV(T,V1(:,1:dim),V2(:,1:dim));
        
            dtemp = can1 - can2; Sdtemp = dtemp*dtemp';
            Sb = Sb + Sdtemp; nb = nb+1;
            end
        end
    end
end % End of the loop for the Between-class sets


% Step-3 : Compute the discriminant transformation matrix T
Sdw = Sw/(nw); Sdb = Sb/(nb);
if (rank(Sdw) < size(Sdw, 1) || rank(Sdb) < size(Sdb, 1)), break; end
Sd = inv(Sdw)*Sdb;

fprintf('log(det) :'); jdet(iter) = log(det(Sd))

if(iter>1)
if(jdet(iter)<jdet(iter-1)) break; end
end

[V D] = eig(Sd);
T = V; 

end % End of loop 'iter'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Get final T
if(dims==img_dim) 
    Tf = T;
else % In the case of 'Dimension Reduction'
    Tf = P*T;
end