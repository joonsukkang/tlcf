% parameters: m, p, n, s, T, a
nvals = [30,40,50,60,70,80,90,100];
mvals = [2,4,6,8,10,12,14,16,18,20];
nrep = 100;

errors = zeros(length(nvals)*length(mvals)*nrep,4);
[ngrid,mgrid] = meshgrid(nvals,mvals);
ngrid = ngrid(:);
mgrid = mgrid(:);

errors = zeros(length(nvals)*length(mvals),4);
errors(:,1) = ngrid;
errors(:,2) = mgrid;
errors = repmat(errors,nrep,1);
errors(:,3) = repelem(1:nrep, length(nvals)*length(mvals));

% run for p=100
p = 100;
for i = 1:length(errors)
    ans_temp = altmin(errors(i,2),p,errors(i,1),20,10,0.9);
    errors(i,4) = ans_temp(end);
end
writematrix(errors,'../output/errors_p100.csv');

% run for p=1000
p = 1000;
errors_p1000 = errors;
errors_p1000(:,4) = 0;

for i = 1:length(errors_p1000)
    ans_temp = altmin(errors_p1000(i,2),p,errors_p1000(i,1),20,10,0.9);
    errors_p1000(i,4) = ans_temp(end);
end
writematrix(errors_p1000,'../output/errors_p1000.csv');

% run for p=100, m=14
nrep=100;
T=10;
errors_p100_m14 = zeros(length(nvals)*nrep,T+1);
errors_p100_m14(:,1) = repelem(nvals, nrep);
for i = 1:length(errors_p100_m14)
    errors_p100_m14(i,2:(T+1)) = altmin(14,100,errors_p100_m14(i,1),20,T,0.9);
end
writematrix(errors_p100_m14,'../output/errors_p100_m14.csv');

