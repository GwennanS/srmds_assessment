% clear workspace
%clear;

% MATLAB datasets, comment a different one for another dataset
% load cities
% load stockreturns
%load humanactivity
%load fisheriris
 load ovariancancer

% x = ratings; % for cities
% x = stocks; % for stockreturns
% x = feat.'; % for humanactivity (watch out this is a big one)
%x = meas.'; % for fisheriris
 x = obs.';
 
tic

% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x,2); % calculate sum
x_bar = (1/n) * x_sum; % use formula from slides

% 2. Compute the centered points
y = x - x_bar; % use formula from slides

% 3. Compute the covariance matrix
c = 1/n * (y *  y.'); % use formula from slides

% 4. Compute eigenvalues and eigenvectors of the covariance matrix
[eigvec,eigvalmat] = eig(c);
eigval = diag(eigvalmat);
[eigval,ind]=sort(eigval, 'descend');
eigvec = normalize(eigvec(:, ind), 'scale');
d = 5;

%compute projections
new = zeros(n, m);
for j = 1:d
    %xi = (y).' * eigvec(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (y).' * (eigvec(:,j));
end
toc 

a = 1;
% Compute the modes
for  i = 1:size(eigvec,2)
%    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i)) + x_bar;
%    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i)) + x_bar;
end


% evaluate 
diffeig = sum(eigval(1:d))/sum(eigval);

xnew = zeros(n, m);
for j = 1:d
    xnew =  xnew+ new(:,j) * (eigvec(:,j)).';
end
xnew = xnew.' + x_bar;

dif = norm(x - xnew);

% Visualize matrix
figure
%scatter((new(:,1)*eigval(end)), (new(:, 2)*eigval(end-1)))

% Visualize the affine subspace of dimension 1, 2 or 3
%figure;
%plot(new(:, 1));
%figure;
%gscatter((new(:,1)), (new(:,2)), actid, 'rgbmc')
%gscatter(new(:,1), new(:, 2), species, 'rgb')
gscatter((new(:,1)), (new(:,2)), grp, 'rg')
%scatter3(new(:,1), new(:, 2), new(:,3), 3,  grp2idx(grp), 'filled')
%colormap([1 0 0; % red
%              0 0 1]); % blue  
% Visualize modes
mode = 1; % indicate which mode
%figure
steps = linspace(1,size(x_bar,1),size(x_bar,1))';
%fill([steps;flipud(steps)],[m_min(:,mode);flipud(m_max(:,mode))],[.9 .9 .9],'linestyle','none');
%line(steps,x_bar)
