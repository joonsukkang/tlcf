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
    errors(i,4) = altmin(errors(i,2),p,errors(i,1),20,10,0.9);
end
writematrix(errors,'../output/errors_p100.csv');

% run for p=1000
p = 1000;
errors_p1000 = errors;

for i = 1:length(errors_p1000)
    errors_p1000(i,4) = altmin(errors_p1000(i,2),p,errors_p1000(i,1),20,10,0.9);
end
writematrix(errors_p1000,'../output/errors_p1000.csv');