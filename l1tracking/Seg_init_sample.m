function [outs] = Seg_init_sample(nsamples, mean_afnv, std_afnv)
%Initialize the afnv samples using normal prior distribution
% 1-6: a11, a12, a21, a22, tr, tc 
% 7:wgt, 8:csum

%randn('state', sum(100*clock));

MV_LEN = 6;
mean_afnv(1) = log(mean_afnv(1));
mean_afnv(4) = log(mean_afnv(4));

outs = zeros([nsamples, MV_LEN+2]); 

outs(:,1:MV_LEN) = randn([nsamples, MV_LEN])*diag(std_afnv) ...
    + ones(nsamples,1)*mean_afnv;

%use rotation only  
%outs(:, 3) = -outs(:,2);
%outs(:, 4) = outs(:,1);

outs(:,1) = exp(outs(:,1));
outs(:,4) = exp(outs(:,4));