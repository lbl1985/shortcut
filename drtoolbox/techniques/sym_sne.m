function Y = sym_sne(X, d, perplexity)
%SNE Implementation of symmetric Stochastic Neighbor Embedding
%
%   mappedX = sym_sne(X, no_dims, perplexity)
%
% Runs the symmetric Stochastic Neighbor Embedding algorithm. The 
% high-dimensional datapoints are specified by X. The target dimensionality
% is specified in no_dims (default = 2), and the perplexity of the Gaussian
% kernel is specified in perplexity (default = 30). 
% The function returns the embedded points in mappedX.
%

% This file is part of the Matlab Toolbox for Dimensionality Reduction v0.7b.
% The toolbox can be obtained from http://ticc.uvt.nl/~lvdrmaaten
% You are free to use, change, or redistribute this code in any way you
% want for non-commercial purposes. However, it is appreciated if you 
% maintain the name of the original author.
%
% (C) Laurens van der Maaten
% Tilburg University, 2008



    if ~exist('d', 'var') || isempty(d)
        d = 2;
    end
    if ~exist('perplexity', 'var') || isempty(perplexity)
        perplexity = 30;
    end

    % Initialize some variables
    n = size(X, 1);                 % number of instances
    eta = .05;                      % learning rate
    max_iter = 4000;                % maximum number of iterations
    jitter = 0.3;                   % initial jitter
    jitter_decay = 0.99;            % jitter decay
    momentum = 0.5;                 % initial momentum
    final_momentum = 0.8;           % final momentum
    mom_switch_iter = 750;          % iteration where momentum changes
    
    % Initialize embedding coordinates randomly (close to origin)
    Y = 0.0001 * rand(n, d);
    dC = zeros(n, d);
    y_incs = zeros(n, d);
    
    % Compute Gaussian kernel for high-dimensional data representation
    P = x2p(X, perplexity, 1e-5);                                        % use fixed perplexity
    P = P + P';
    P = P ./ sum(P(:));
    P = max(P, eps);
        
    % Iterating loop
    for iter=1:max_iter

        % Compute Gaussian kernel for low-dimensional data representation
        sum_Y = sum(Y .^ 2, 2);                                                     % precomputation for pairwise distances
        Q = exp(-bsxfun(@plus, sum_Y, bsxfun(@plus, sum_Y', -2 * Y * Y')) ./ 2);    % Gaussian probabilities
        Q = Q ./ repmat(sum(Q, 2), [1 n]);
        Q = max(Q, eps);
        
        % Compute cost function between P and Q
        if ~rem(iter, 20)
            costs = sum(P .* log((P + eps) ./ (Q + eps)), 2) ./ n;              % division by n corrects for # of datapoints
            cost = sum(costs);
            disp(['Iteration ' num2str(iter) ': error is ' num2str(cost)]);
        end
        
        % Compute gradient
        PQ = P - Q;
        for i=1:n
            dC(i,:) = sum(bsxfun(@times, bsxfun(@minus, Y(i,:), Y), PQ(i,:)'), 1);
        end
            
        % Perform the gradient search
        y_incs = momentum * y_incs - eta * dC;
        Y = Y + y_incs;
		Y = Y + jitter * randn(size(Y));
        Y = bsxfun(@minus, Y, mean(Y, 1));
        
        % Reduce jitter over time and change momentum
        jitter = jitter * jitter_decay;
        if iter == mom_switch_iter
            momentum = final_momentum;
        end
    end
  