function H = ftc2HankelS_diff(ftc, threshold)
% calculate the Sim Matrix according to Rank of Hankel matirx according to 
% f2 - f1 pairwise. 
% Output H, the Sim matrix. Actually, it should be called as Sim...

% Example: ftc2Hankel(ftc, 2e-4)
% Comparing to: ftc2HankelRank.

[m n] = size(ftc);
if mod(n, 2)
%     ftc = ftc(:, 1 : end-1);
%     n = n - 1;
    n = n + 1;
end

lambda = (n) ^ ( -.5);  totalnum = nchoosek(m, 2);
H = zeros(m);
count = 0;
ticstatusid = ticstatus('ftc2HankelS_diff',[],40);
for i = 1 : m
    for j = i + 1 : m
        diff = ftc(i, :) - ftc(j, :);
        Hankel_t = hankel(diff(1 : n / 2), diff(n / 2 : n - 1));
        [A E] = proximal_gradient_rpca(Hankel_t, lambda);
        [U S V] = svd(A);
        rank_A = sum(diag(S)>threshold);
        H(i, j) = rank_A;        H(j, i) = rank_A;
        count = count + 1;
        tocstatus( ticstatusid, count/totalnum );        
    end
end