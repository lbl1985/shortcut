% Recognition ftn. 
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006
% Modified by T-K. Kim, 27 Aug 2006 

function id = Recog(Model,Query,T,...
                n_class,pca_dim,ang_dim,flag_dcc);

dim = pca_dim;
nset = size(Model,2)/n_class/dim;

score = zeros(n_class,1);
for k=1:n_class
    temp_s = zeros(nset,1);
    for j=1:nset
        Ptr = Model(:,(k-1)*nset*dim+(j-1)*dim+1:(k-1)*nset*dim+(j-1)*dim+dim);
        if(flag_dcc=='ON') % A unit comparison ftn. by discriminative canonical correlation
            temp_s(j,1) = Compare_By_DCC(Ptr,Query,T,ang_dim); 
        else % A unit comparison ftn. by canonical correlations
            temp_s(j,1) = Compare_By_CC(Ptr,Query,ang_dim); 
        end
    end
    score(k,1) = max(temp_s);
end

id = find(score==max(score));