% Multidimensional scaling (MDS
% MATLAB KmeansData dataset

load kmeansdata

% Similarity matrix calculation - pairwise euclidian distance between cities
proximities = zeros(size(X,1));

for i=1:size(X,1)
    for j =1:size(X,1)
        proximities(i,j) = pdist2(X(i,:),X(j,:),'euclidean');
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
X_new = eigvec1*A;

for i=1:size(X_new,1)
    for j =1:size(X_new,1)
        proximities_new(i,j) = pdist2(X_new(i,:),X_new(j,:),'euclidean');
    end
end

stress = (proximities_new - proximities).^2;
stress = sum(stress,'all')/2;

% We can now look at our cities in 2D:
%plot(X_new(:,1),X_new(:,2),'o')
gscatter(X_new(:,1),X_new(:,2))
title('Example of Classical MDS with M=2 for Ionosphere Data');
xlabel('Basis Vector - 1')
ylabel('Basis Vector - 2')

