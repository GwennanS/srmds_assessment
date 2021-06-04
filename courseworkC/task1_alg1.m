% MATLAB cities dataset
load cities
x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x);             % calculate sum
x_bar = 1/n * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 3. Compute the covariance matrix
c = 1/n * y * y.';     % use formula from slides

% 4. Compute eigenvalues and eigenvectors of the covariance matrix
[eigvec,eigval] = eig(c);

