% MATLAB cities dataset
clear;

% 0. load data
load fisheriris
%load humanactivity
%load cities

x = meas;
%x = feat;
%x = ratings;

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x);             % calculate sum
x_bar = 1/n * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% snapshot data
%random
rand = randsample(m,round(m/10) );
yr = y(rand, :);
%periodically
yr = y(1:10:end, :);

% 3. Compute the Gram matrix
g = yr.' * yr;     % use formula from slides

% 4.Compute eigenvalues and eigenvectors of 1/m G and sort
[eigvec,eigval] = eig(1/n * g, 'vector'); 
[eigval,ind]=sort(eigval);
eigvec = eigvec(:, ind);

% 5. Compute the basis vectors of the affine spaces
for i = 1:size(eigvec,2)
    u(:,i) = y * eigvec(:,i) * inv(sqrtm(eigval(i))); 
end

% Other way of computing u because I didn't understand wtf we were doing
new = zeros(m, d);
for j = 1:size(eigval)
    xi = (x-x_bar) * eigvec(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (x-x_bar) * eigvec(:,j);
end

% find dimention (by hand)
d = 2;
diffeig = sum(eigval(end-d:end))/sum(eigval);

% Visualize the affine subspace of dimension 1, 2 or 3
figure;
plot(u(:, end)); %ToDo: add color per cat
figure;
scatter3(u(:,1), u(:, 2), u(:,3),1,  species, 'filled')
colormap([1 0 0; % red
              0 0 1; % blue    
              0 .5 .5; %     
              0 .5 1; %     
              0 1 0]);% green
figure;
gscatter(u(:,end-1), u(:, end), species, 'rgb')


