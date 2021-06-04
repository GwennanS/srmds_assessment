% MATLAB cities dataset
load cities
x = ratings;

% 1. Compute the center of the points
n = size(x,1); % get size
s = sum(x);             % calculate sum
x_bar = 1/n * s;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 3. Compute the Gram matrix
g = y.' * y;     % use formula from slides

% 4.Compute eigenvalues and eigenvectors of 1/m G
[eigvec,eigval] = eig(1/n * g); 

% 5. Compute the basis vectors of the affine spaces
for i = 1:size(eigvec,1)
    u(:,i) = y * eigvec(:,i) * inv(sqrtm(eigval(i,i))); 
end
