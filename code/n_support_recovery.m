function [n_result] = n_support_recovery(n, K, s, p, gamma, beta, support)

% generate data
X = normrnd(0,1,n,p,K+1);
epsilon = normrnd(0,1,n,1,K+1);
delta = zeros(p,1,K+1);
for i = 1:K
    delta(:,:,i+1) = gamma*diag(beta)*diag(normrnd(0,1,p));
end

Y = zeros(n,1,K+1);
for i = 1:(K+1)
    Y(:,:,i) = X(:,:,i)*(beta+delta(:,:,i))+epsilon(:,:,i);
end

% step 1: support recovery  -----------------------------------------------
Xstack = zeros(n*(K+1),p);
Ystack = zeros(n*(K+1),1);
for i = 1:(K+1)
    Xstack(((i-1)*n+1):(i*n), :) = X(:,:,i);
    Ystack(((i-1)*n+1):(i*n), 1) = Y(:,:,i);
end

% HTP: with known s
[b_HTP_0, s_HTP_0] = HTP(Y(:,:,1),X(:,:,1),s); % only using observation data
[b_HTP, s_HTP] = HTP(Ystack,Xstack,s);

% Lasso: fit without s; later choose first s predictors
[b_lasso_0] = lasso(X(:,:,1),Y(:,:,1)); % only using observation data
[b_lasso] = lasso(Xstack,Ystack);

s_lasso = transpose(1:p);
s_lasso(:,2) = sum(b_lasso~=0 , 2);
s_lasso = sortrows(s_lasso, 2,'descend'); % choose s predictors which become nonzero earlier in the fit
s_lasso = sort(s_lasso(1:s,1));

s_lasso_0 = transpose(1:p);
s_lasso_0(:,2) = sum(b_lasso_0~=0 , 2);
s_lasso_0 = sortrows(s_lasso_0, 2,'descend'); % choose s predictors which become nonzero earlier in the fit
s_lasso_0 = sort(s_lasso_0(1:s,1));


% number of recovered support
n_HTP = length(intersect(s_HTP, support));
n_HTP_0 = length(intersect(s_HTP_0, support)); % using only observation data
n_lasso = length(intersect(s_lasso, support));
n_lasso_0 = length(intersect(s_lasso_0, support)); % using only observation data

n_result = [n_HTP, n_HTP_0, n_lasso, n_lasso_0];
