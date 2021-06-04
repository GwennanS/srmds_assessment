% MATLAB cities dataset
load cities
x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x);             % calculate sum
x_bar = 1/n * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 3. Compute the Gram matrix
g = y.' * y;     % use formula from slides
[m,n] = size(g); % get size (m=row, n=column)

% 4. Select only a fraction of the data points (snapshots)
snapshot = g([1:n/2],[1:n/2]); % must be square

% 5. Compute the PCA using the Gram matrix of only the selected data points
[eigvec,eigval] = eig(1/n * snapshot); 

% and now basis vectors?
for i = 1:size(eigvec,2)
    u(:,i) = y(:,[1:n/2]) * eigvec(:,i) * inv(sqrtm(eigval(i,i))); 
end
