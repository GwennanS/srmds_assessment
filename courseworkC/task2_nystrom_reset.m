clear;
% 0. load dataset
%load cities
load fisheriris
x = meas;
%x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x,2);             % calculate sum
x_bar = 1/m * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 2.5 Sample snapshot (not used current implementation)
% first l
yr= y(:, 1:n/2);
% random
rand = randsample(n,round(n/10) );
%yr = y(: , rand);
% periodically
%yr = y(:,1:1:end);

% 3. Compute the covariance matrix
call = 1/n * y *  y.';     % use formula from slides
c = call(1:ceil(end/5),1:ceil(end/5));
b = call(ceil(end/5)+1:end,1:ceil(end/5));

% 4. Compute eigenvalues and eigenvectors of the samller covariance matrix
[eigvec,eigvalmat] = eig(c);
eigval = diag(eigvalmat);
[eigval,ind]=sort(eigval, 'descend');
eigvec = eigvec(:, ind);

% Create U-tilde
utilde = zeros(m, size(c,1));
utilde(1:size(c,1), :) = c;
utilde(size(c,1)+1:end, :) = (b * eigvec )* inv(eigvalmat);

% Visualize matrix
figure
gscatter((call(:,1).*utilde(:,1)), (call(:, 2).*utilde(:,2)), species, 'rgb')

