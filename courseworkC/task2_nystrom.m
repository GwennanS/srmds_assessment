% MATLAB cities dataset
load cities
x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x);             % calculate sum
x_bar = 1/n * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 3. Select a subset S of the set {1,2,...,n}
s = x(:,[1:n/2]);
[m,n] = size(s);

% 4. For all i in S compute the columns of the Covariance matrix C resulting
% in a matrix C~
% ?? so use the covariance matrix to compute it or wtf??
% I'm now computing the covariance matrix of only the subset s
c = 1/n * y(:,[1:n/2]) * y(:,[1:n/2]).';     % use formula from slides
