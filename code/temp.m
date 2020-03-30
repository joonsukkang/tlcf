
% parameters: m, p, n, s, T, a
m=4;
p=1000;
n=60;
s=20;
T=10;
a=0.9;

% cannot recover beta even without noise

theta = transpose(repelem([1, -1, 0], [s/2, s/2, p-s]));
Sigma_small = [1, a; a, 1];
Sigma = kron(eye(m/2), Sigma_small);
Sigma_sqrt = sqrtm(Sigma);
Sigma_sqrt_inv = inv(Sigma_sqrt);

% generate data
X = normrnd(0,1,m,p,n);
Y = zeros(m,1,n);
for i = 1:n
    Y(:,:,i) = X(:,:,i)*theta;
end

% vectorize
Yvec = zeros(m*n,1);
Xvec = zeros(m*n,p);
for i = 1:n
    Yvec(((i-1)*m+1):(i*m),1) = Y(:,:,i);
    Xvec(((i-1)*m+1):(i*m),:) = X(:,:,i);
end
theta_hat = HTP(Yvec,Xvec,s);
norm(theta-theta_hat)

