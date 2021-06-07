% MATLAB cities dataset
clear;
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

% 4.Compute eigenvalues and eigenvectors of 1/m G
[eigvec,eigval] = eig(1/m * g); 

% 5. Compute the basis vectors of the affine spaces
for i = 1:size(eigvec,2)
    u(:,i) = y * eigvec(:,i) * inv(sqrtm(eigval(i,i))); 
end

% Visualize matrix
figure
scatter(u(:,end-1), u(:, end))

a = 2;
% modes
for  i = 1:size(eigvec,2)
    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar.';
    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar.';
end

% Visualize modes
figure
steps = linspace(0,1,size(x_bar,2))';
fill([steps;flipud(steps)],[m_min(:,1);flipud(m_max(:,1))],[.9 .9 .9],'linestyle','none');
line(steps,x_bar)
