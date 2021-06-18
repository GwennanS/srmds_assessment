% clear workspace
clear;

% MATLAB datasets, comment a different one for another dataset
%load cities
%load stockreturns
%load humanactivity
%load fisheriris
load ovariancancer
%load('mixoutALL_shifted.mat')


% x = ratings; % for cities
% x = stocks; % for stockreturns
%x = feat.'; % for humanactivity (watch out this is a big one)
%x = meas.'; % for fisheriris
x = obs.' ;

tic

%1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x, 2); % calculate sum
x_bar = (1/n) * x_sum; % use formula from slides

% 2. Compute the centered points
y = x - x_bar; % use formula from slides

% 3. Compute the Gram matrix
g = y.' * y; % use formula from slides
toc
tic
% 4.Compute eigenvalues and eigenvectors of 1/m G
[eigvec2,eigvalmat2] = eig(1/n * g); % use formula from slides
eigval2 = diag(eigvalmat2);
[eigval2,ind]=sort(eigval2, 'descend');
eigvec2 = eigvec2(:, ind);

d = 3;
% 5. Compute the basis vectors of the affine spaces
% since we have to take eigenvalue i,i we have to do a for loop
for i = 1:d
    u2(:,i) =  1/(sqrt(eigval2(i))) * (y * (eigvec2(:,i))) ; 
end

%compute projections
new = zeros(n, m);
for j = 1:d
    %xi = (y).' * eigvec(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (y).' * u2(:,j);
end

toc


% evaluate 
diffeig = sum(eigval2(1:d))/sum(eigval2);
xnew = zeros(n, m);
for j = 1:d
    xnew =  xnew+ new(:,j) * u2(:,j).';
end
xnew = xnew.' + x_bar;

dif = norm(x - xnew);


% Visualize matrix
%figure;
%scatter(new(:,1), new(:, 2));

% Visualize the affine subspace of dimension 1, 2 or 3
%figure;
%plot(new(:, 1));
figure;
gscatter(new(:,1), new(:, 2), grp, 'rg')
%gscatter(new(:,1), new(:, 2), actid, 'rgbmc')
xlabel("first coordinate of projection x'")
ylabel("second coordinate of projection x'")
%figure;
%scatter3(new(:,1), new(:, 2), new(:,3), 3,  grp2idx(grp), 'filled')
%colormap([1 0 0; % red
%              0 0 1]); % blue    
%              0 1 1; %     
%              1 1 0; %     
%              0 1 0]);% green
a = 1;
% Calculate the modes
for  i = 1:size(eigvec,2)
%    m_max(:,i) = a * eigvec(:,i) * sqrt(eigval(i)) + x_bar;
%    m_min(:,i) = -a * eigvec(:,i) * sqrt(eigval(i)) + x_bar;
end

% Visualize the modes
mode = 2; % Indicate which mode
%figure;
steps = linspace(1,size(x_bar,2),size(x_bar,2))';
%fill([steps;flipud(steps)],[m_min(:,mode);flipud(m_max(:,mode))],[.9 .9 .9],'linestyle','none'); % the grey area
%line(steps,x_bar)
