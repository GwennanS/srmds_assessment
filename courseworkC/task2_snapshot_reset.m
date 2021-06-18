clear;

% 0. load data
%load fisheriris
load humanactivity
%load cities
%load ovariancancer

%x = obs.';
%x = meas.';
x = feat.';
%x = ratings;
d = 2;
tic
% 1. Compute the center of the points
[m,n] = size(x); % get size (m=row, n=column)
x_sum = sum(x);             % calculate sum
x_bar = 1/n * x_sum;       % use formula from slides

% 2. Compute the centered points
y = x - x_bar;          % use formula from slides

% 2.5 Sample data
%random
rand1 = randsample(floor(n/5),floor(n/50) );
rand2 = rand1 + floor(n/5);
rand3 = rand2 + floor(n/5);
rand4 = rand3 + floor(n/5);
rand5 = rand4 + floor(n/5);
yr = y(:, [rand1 rand2 rand3 rand4 rand5]);
%periodically
%yr = y(:, 1:10:end);

% 3. Compute the Gram matrix
g = yr.' * yr;     % use formula from slides

% 4.Compute eigenvalues and eigenvectors of 1/m G and sort
[eigvec,eigvalmat] = eig(1/m *g); % use formula from slides
eigval = diag(eigvalmat);
[eigval,ind]=sort(eigval, 'descend');
eigvec = eigvec(:, ind);

% 5. Compute the basis vectors of the affine spaces
for i = 1:d
    u(:,i) =( yr * eigvec(:,i)) * 1/(sqrt(eigval(i))); 
end
toc

% Other way of computing u because I didn't understand wtf we were doing
new = zeros(n, m);
for j = 1:d
    %xi = (x-x_bar).' * u(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (y).' * u(:,j);
end

% evaluate 
diffeig = sum(eigval(1:d))/sum(eigval);
xnew = zeros(n, m);
for j = 1:d
    xnew =  xnew+ new(:,j) * u(:,j).';
end
xnew = xnew.' + x_bar;

dif = norm(x - xnew);


% Visualize the affine subspace of dimension 1, 2 or 3

% 1D 
%x= u(:, end);
% for ii = 1:length(x)
%       y = x(ii);  % Data point ii has come in.
%       if actid(ii) == 1
%           c = 'r.';
%       elseif actid(ii) ==2
%           c = 'b.';
%       elseif actid(ii) == 3
%           c = 'g.';
%        elseif actid(ii) == 4
%           c = 'm.';
%       elseif actid(ii) == 5
%           c = 'c.';
%       else 
%           c = 'y*';
%       end
%       plot(ii, y,c)
%       hold on
% end
  
%for ii = 1:length(x)
%      y = x(ii);  % Data point ii has come in.
%      if strcmp(species(ii) , 'setosa')
%          c = 'r*';
%      elseif strcmp(species(ii), 'versicolor')
%          c = 'b*';
%      elseif strcmp(species(ii) , 'virginica')
%          c = 'g*';
%      else 
 %         c = 'm*';
%      end
%      plot(ii, y,c)
%      hold on
%end
  
% 2D
figure;
gscatter(new(:,1), new(:, 2), actid, 'rgbmc')
%gscatter(new(:,1), new(:,2), species, 'rgb')
%gscatter(new(:,1), new(:, 2), grp, 'rg')

% 3D
%figure;
%scatter3(u(:,1), u(:, 2), u(:,3), 1,  actid, 'filled')
%colormap([1 0 0; % red
%              0 0 1; % blue    
%              0 1 1; %     
%              1 1 0; %     
%              0 1 0]);% green

