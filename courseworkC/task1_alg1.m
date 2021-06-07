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
c = 1/n * y *  y.';     % use formula from slides

% 4. Compute eigenvalues and eigenvectors of the covariance matrix
[eigvec,eigval] = eig(c);

a = 2;
% Compute the modes
for  i = 1:size(eigvec,2)
    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar;
    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar;
end

% Visualize matrix
figure
scatter((c(:,end-1)*eigval(end,end)), (c(:, end)*eigval(end-1,end-1)))

% Visualize modes
figure
steps = linspace(0,1,size(x_bar,1))';
fill([steps;flipud(steps)],[m_min(:,1);flipud(m_max(:,1))],[.9 .9 .9],'linestyle','none');
line(steps,x_bar)
