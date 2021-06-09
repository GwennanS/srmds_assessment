load cities

Y = tsne(ratings,'Algorithm','exact','Distance','cosine');
gscatter(Y(:,1),Y(:,2))
title('Cosine')

Y = tsne(ratings,'Algorithm','exact','Distance','chebychev');
figure()
gscatter(Y(:,1),Y(:,2))
title('Chebychev')

Y = tsne(ratings,'Algorithm','exact','Distance','euclidean');
figure()
gscatter(Y(:,1),Y(:,2))
title('Euclidean')
