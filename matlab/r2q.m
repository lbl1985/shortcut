function q = r2q(D, swch)
% This function is used to transfer the direction cosine matrix(DCM) into
% the quaternion of rotation (Q matrix).
% This method is described by the paper: 
% <<New mthod for extracting the quaternion from a rotation matrix>> AIAA
% Journal of Guidance, Control and Dynamics 23(6): 1085-1087 ISSN 0731-5090
% T1.J4140
% According to the the paper above, we do have two situation to handle. 
% 1) The given DCM is indeed orthogonal
% 2) the given DCM is an Imprecise DCM
% 
% Size of D should be 3 by 3
% *********************************************
% % Example 1
% D = [-0.545 0.797 0.260; 0.733 0.603 -0.313; -0.407 0.021 -0.913];
% r1 = [1; 0; 0];
% r2 = [0; 1; 0];
% b1 = D * r1;
% b2 = D * r2;
% K2 = D2K2(D);
% [V, S] = eig(K2);
% q = V(:, end)
% ---------------------------------------------
% q = [0.4373; 0.8748; -0.0835; -0.1909];
% *********************************************
% Example 2
% D = [.395 .362 .843; -.626 .796 -.056; -.677 -.498 .529];
% r1 = [1; 0; 0];
% r2 = [0; 1; 0];
% r3 = [0; 0; 1];
% b1 = D * r1;
% b2 = D * r2;
% b3 = D * r3;
% D3 = D * (D' * D) ^ (-1/2);
% [V, S] = eig(D2K2(D3));
% q = V(:, end)
% ---------------------------------------------
% q = [0.1361; -0.4634; 0.2979; 0.8234];

[m, n] = size(D);
if m ~= 3 || n~= 3
    error('The size of D should be 3 by 3');
end

switch swch
    case '1'
        r1 = [1; 0; 0];
        r2 = [0; 1; 0];
        b1 = D * r1;
        b2 = D * r2;
        K2 = D2K2(D);
        [V, S] = eig(K2);
        q = V(:, end);
    case '2'
        r1 = [1; 0; 0];
        r2 = [0; 1; 0];
        r3 = [0; 0; 1];
        b1 = D * r1;
        b2 = D * r2;
        b3 = D * r3;
        D3 = D * (D' * D) ^ (-1/2);
        [V, S] = eig(D2K2(D3));
        q = V(:, end);
end

function K2 = D2K2(d)
K2 = 1/2 * [d(1, 1) - d(2, 2) d(2, 1) + d(1, 2) d(3, 1) -d(3, 2); 
    d(2, 1) + d(1, 2) d(2, 2) - d(1, 1) d(3, 2) d(3, 1);
    d(3, 1) d(3, 2) -d(1, 1) - d(2,2) d(1, 2) - d(2, 1);
    -d(3, 2) d(3, 1) d(1, 2) - d(2, 1) d(1, 1) + d(2, 2)];

function K3 = D2K3(d)
K3 = 1/3 * [d(1, 1) - d(2, 2) - d(3, 3) d(2, 1) + d(1, 2) d(3, 1) + d(1, 3) d(2, 3) - d(3, 2);
    d(2, 1) + d(1, 2) d(2, 2) - d(1, 1) - d(3, 3) d(3, 2) + d(2, 3) d(3, 1) - d(1, 3);
    d(3, 1) + d(1, 3) d(3, 2) + d(2, 3) d(3, 3) - d(1, 1) - d(2, 2) d(1, 2) - d(2, 1);
    d(2, 3) - d(3, 2) d(3, 1) - d(1, 3) d(1, 2) - d(2, 1) d(1, 1) + d(2, 2) + d(3, 3)];