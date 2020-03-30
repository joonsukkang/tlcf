rng(773); % set seed

p=100;
s=10;
gamma=0.1;

beta = zeros(p,1);
support = sort(randsample(p,s));
beta(support,1) = 1;


% parameters: n, K, s, p, gamma, beta, support
nvals = [10,20,30,50,100];
Kvals = [1,2,3,5,10,20,30];
nrep = 100;

[ngrid, Kgrid, itergrid] = meshgrid(nvals,Kvals,1:nrep);
ngrid = ngrid(:);
Kgrid = Kgrid(:);
itergrid = itergrid(:);

n_support_recovery_p100 = zeros(length(itergrid),7);
n_support_recovery_p100(:,1:3) = [ngrid,Kgrid,itergrid];

%n_support_recovery(n, K, s, p, gamma, beta, support)
for i = 1:length(n_support_recovery_p100)
    n_support_recovery_p100(i,4:7) = n_support_recovery(...
        n_support_recovery_p100(i,1),...
        n_support_recovery_p100(i,2),...
        s,p,gamma,beta,support);
end

writematrix(n_support_recovery_p100,'../output/n_support_recovery_p100.csv');