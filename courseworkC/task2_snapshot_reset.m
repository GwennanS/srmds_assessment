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

% 2.5 Sample data
%random
rand = randsample(m,round(m/10) );
%yr = y(rand, :);
%periodically
yr = y(1:1:end, :);

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
new = zeros(m, length(eigval));
for j = 1:length(eigval)
    xi = (x-x_bar) * eigvec(:,j);
    %xi = ((x-x_bar).' .* U(:,j)) .* U(:,j) + x_bar.';
    new(:,j) = (x-x_bar) * eigvec(:,j);
end

% find dimention (by hand)
d = 2;
diffeig = sum(eigval(end-d:end))/sum(eigval);

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
%gscatter(u(:,end-1), u(:, end), actid, 'rgbmc')
gscatter(u(:,end-1), u(:, end), species, 'rgb')

% 3D
%figure;
%scatter3(u(:,1), u(:, 2), u(:,3), 1,  actid, 'filled')
%colormap([1 0 0; % red
%              0 0 1; % blue    
%              0 1 1; %     
%              1 1 0; %     
%              0 1 0]);% green

