clear;
% MATLAB datasets, comment a different one for another dataset
% load cities
% load stockreturns
% load humanactivity
%load fisheriris
load ovariancancer

% x = ratings; % for cities
% x = stocks; % for stockreturns
 %x = feat.'; % for humanactivity (watch out this is a big one)
%x = meas; % for fisheriris
x = obs.';

d = 5;
tic
% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x,2); % calculate sum
x_bar = (1/n) * x_sum; % use formula from slides

% 2. Compute the centered points
y = x - x_bar; % use formula from slides

% 2.5 Sample snapshot (not used current implementation)
% first l
yr= y( 1:m/2,:);
% random
index = [1:m];
index = index(randperm(length(index)));
rand = randsample(m,round(m/10) );
%yr = y(: , rand);
% periodically
%yr = y(:,1:1:end);

% 3. Compute the covariance matrix
call = 1/n * (y *  y.');     % use formula from slides
call = call(index,index);
ct = call(1:ceil(end/5),1:ceil(end/5));
b = call(ceil(end/5)+1:end,1:ceil(end/5));

% 4. Compute eigenvalues and eigenvectors of the samller covariance matrix
[eigvec2,eigvalmat] = eig(ct);
eigval = diag(eigvalmat);
[eigval,ind]=sort(eigval, 'descend');
eigvec2 = eigvec2(:, ind);

% Create U-tilde
utilde = zeros(m,size(eigvec2,1));
utilde( 1:size(eigvec2,1),:) = eigvec2;
utilde(size(eigvec2,1)+1:end,:) = (b * eigvec2 )* (inv(eigvalmat));

%compute projections
new = zeros(n, m);
for j = 1:d
    %xi = (y).' * eigvec(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (y).' * (utilde(:,j));
end
toc 

% evaluate 
diffeig = sum(eigval(1:d))/sum(eigval);

xnew = zeros(n, m);
for j = 1:d
    xnew =  xnew+ new(:,j) * (utilde(:,j)).';
end
xnew = xnew.' + x_bar;

dif = norm(x - xnew);

% Visualize matrix
figure
%gscatter((new(:,1)), (new(:,2)), actid, 'rgbmc')
gscatter(new(:,1), new(:, 3), grp, 'rg')
figure;
%scatter3(new(:,1), new(:, 2), new(:,3), 3,  grp2idx(grp), 'filled')
colormap([1 0 0; % red
              0 0 1]); % blue 
