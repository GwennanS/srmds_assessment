% Multidimensional scaling (MDS
% MATLAB cities dataset
load cities

% Data has cities in rows, and different categories for ratings in
% columns.

% Similarity matrix calculation - pairwise euclidian distance between cities
proximities = zeros(size(ratings,1));

for i=1:size(ratings,1)
    for j =1:size(ratings,1)
        proximities(i,j) = pdist2(ratings(i,:),ratings(j,:),'euclidean');
    end
end

% Gram Matrix using double centering

n = size(proximities,1); 
identity = eye(n); %identity matrix of size n (proximity matrix size)
one = ones(n); % same sized matrix of 1's

% gram/centering matrix
centering_matrix = identity - (1/n) * one;

J = centering_matrix;

% applying double centering
B = -.5*J*(proximities).*(proximities)*J;

% Extract some M eigen values and vectors
M = 2; % so we can plot in 2D
[eigvec,eigval] = eig(B);

% get the top M
[eigval, order] = sort(max(eigval)','descend');
eigvec1 = eigvec(order,:);
eigvec1 = eigvec1(:,1:M); % eigenvectors are in columns
eigval1 = eigval(1:M);

% Plop them back into the diagonal of a matrix
A = zeros(2);
A(1:3:end) = eigval1;
A = A.^0.5;

% If we multiply eigenvectors by eigenvalues, we get our new representation
% of the data, X:
X = eigvec1*A;

for i=1:size(X,1)
    for j =1:size(X,1)
        proximities_new(i,j) = pdist2(X(i,:),X(j,:),'euclidean');
    end
end

stress = (proximities_new - proximities).^2;
stress = sum(stress,'all')/2;

% We can now look at our cities in 2D:
plot(X(:,1),X(:,2),'o')
title('Example of Classical MDS with M=2 for City Ratings');

% % Grab just the state names
% % NOTE: doesn't work perfectly for all, but it's good enough!
% cities = cell(size(names,1),1);
% for c=1:size(names,1)
%     cities{c} = deblank(names(c,regexp(names(c,:),', ')+2:end));
% end
% 
% % Select a random subset of 20 labels
% y = randsample(size(cities,1),20);
% 
% % Throw on some labels!
% text(X(y,1), X(y,2), cities(y), 'VerticalAlignment','bottom', ...
%                              'HorizontalAlignment','right')