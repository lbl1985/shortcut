
% Main ftn. for learning DCC and recognition 
% Copyright by Tae-Kyun Kim, Department of Engineering, University of
% Cambridge (http://mi.eng.cam.ac.uk/~tkk22)
%
% Written by T-K. Kim, 17 May 2006
% Modified by T-K. Kim, 24 Nov 2006 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input param.
% flag_dcc = 'ON' or 'OFF'; % use of the discriminant function (DCC)
% pca_dim = 10; % Eigen-subspace dimension of each vector set
% ang_dim = pca_dim; % Number of principal angles to aggregate
% img_dim = 20*20; % Input image dimension
% red_dim = 150 or 20*20; % Reduced image dimension to avoid sinularity problem in DCC learning
% dcc_dim <= red_dim % Dimension of DCC transformation matrix

% n_class : Number of object classes in training data 
% n_set : Number of sets of each object class in training data

% Pm (Subspace-basis matrix for training data) : (img_dim) x (n_class*n_sets*pca_dim)
% Pq (Subspace-basis matrix for a test set) : (img_dim) x (pca_dim)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output 
% T (DCC transformation matrix) : (img_dim) x (dcc_dim)
% id : Estimated object class of the test set


% Learning DCC
if(flag_dcc=='ON') % DCC learning
    T = Learn_DCC(Pm,n_class,n_set,pca_dim,red_dim);    
else % Aggregation of canonical correlations w/o the discriminative function 
    T = eye(img_dim,img_dim);
end

T = T(:,1:dcc_dim);
% Test
id = Recog(Pm,Pq,T,...
    n_class,pca_dim,ang_dim,flag_dcc); % recognize a test set
