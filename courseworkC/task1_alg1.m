% MATLAB cities dataset
clear;
load cities
x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x,2);             % calculate sum
x_bar = 1/m * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 3. Compute the covariance matrix
c = 1/n * y * y.';     % use formula from slides

% 4. Compute eigenvalues and eigenvectors of the covariance matrix
[eigvec,eigval] = eig(c);

a = 2;
% modes
for  i = 1:size(eigvec,2)
    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar;
    m_norm(:,i) = eigvec(:,i) * sqrt(eigval(i,i)) + x_bar;
    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar;
end
