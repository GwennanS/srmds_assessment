load kmeansdata


[Y, loss] = tsne(X,'Algorithm','exact','Distance','cosine');
gscatter(Y(:,1),Y(:,2))
xlabel('Basis Vector - 1')
ylabel('Basis Vector - 2')
title('Cosine')

Y = tsne(X,'Algorithm','exact','Distance','chebychev');
figure()
gscatter(Y(:,1),Y(:,2))
xlabel('Basis Vector - 1')
ylabel('Basis Vector - 2')
title('Chebychev')

Y = tsne(X,'Algorithm','exact','Distance','euclidean');
figure()
gscatter(Y(:,1),Y(:,2))
xlabel('Basis Vector - 1')
ylabel('Basis Vector - 2')
title('Euclidean')
