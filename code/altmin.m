function [l2norm_last] = altmin(m,p,n,s,T,a)

    theta = transpose(repelem([1, -1, 0], [s/2, s/2, p-s]));
    Sigma_small = [1, a; a, 1];
    Sigma = kron(eye(m/2), Sigma_small);
    Sigma_sqrt = sqrtm(Sigma);
    Sigma_sqrt_inv = inv(Sigma_sqrt);

    % generate data
    X = normrnd(0,1,m,p,n);
    eta_tilde = normrnd(0,1,m,1,n);
    Y = zeros(m,1,n);
    for i = 1:n
        Y(:,:,i) = X(:,:,i)*theta + Sigma_sqrt*eta_tilde(:,:,i);
    end

    % initialize Sigma hat
    Sigma_hat = eye(m);

    l2norm = zeros(T,1);
    for j = 1:T

        % update theta hat
        Sigma_hat_sqrtinv = sqrtm(inv(Sigma_hat));
        Yvec = zeros(m*n,1);
        Xvec = zeros(m*n,p);
        for i = 1:n
            Yvec(((i-1)*m+1):(i*m),1) = Sigma_hat_sqrtinv*Y(:,:,i);
            Xvec(((i-1)*m+1):(i*m),:) = Sigma_hat_sqrtinv*X(:,:,i);
        end
        theta_hat = HTP(Yvec,Xvec,s);

        % update Sigma hat
        Sigma_hat = zeros(m,m);
        for i = 1:n
            Sigma_hat = Sigma_hat + (Y(:,:,i)-X(:,:,i)*theta_hat)*transpose(Y(:,:,i)-X(:,:,i)*theta_hat)/n;
        end
        
        % save L2 error for theta hat
        l2norm(j) = norm(theta-theta_hat);
    end

    l2norm_last = l2norm(end);
end
