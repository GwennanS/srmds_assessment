% clear workspace
clear;

% MATLAB datasets, comment a different one for another dataset
%load cities
%load stockreturns
% load humanactivity
load fisheriris

% x = ratings; % for cities
% x = stocks; % for stockreturns
% x = feat; % for humanactivity (watch out this is a big one)
x = meas; % for fisheriris

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x); % calculate sum
x_bar = 1/n * x_sum; % use formula from slides

% 2. Compute the centered points
y = x - x_bar; % use formula from slides

% 3. Compute the Gram matrix
g = y.' * y; % use formula from slides

% 4.Compute eigenvalues and eigenvectors of 1/m G
[eigvec,eigval] = eig(1/m * g); % use formula from slides

% 5. Compute the basis vectors of the affine spaces
% since we have to take eigenvalue i,i we have to do a for loop
for i = 1:size(eigvec,2)
    u(:,i) = y * eigvec(:,i) * inv(sqrtm(eigval(i,i))); 
end

% Visualize matrix
figure;
scatter(u(:,end-1), u(:, end));

% Visualize the affine subspace of dimension 1, 2 or 3
figure;
plot(u(:, end));
figure;
gscatter(u(:,end-1), u(:, end), species, 'rgb')

a = 1;
% Calculate the modes
for  i = 1:size(eigvec,2)
    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar.';
    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i,i)) + x_bar.';
end

% Visualize the modes
mode = 2; % Indicate which mode
figure;
steps = linspace(1,size(x_bar,2),size(x_bar,2))';
fill([steps;flipud(steps)],[m_min(:,mode);flipud(m_max(:,mode))],[.9 .9 .9],'linestyle','none'); % the grey area
line(steps,x_bar)
