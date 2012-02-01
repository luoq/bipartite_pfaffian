function B=biadjacency_to_adjacency(A)
% biadjacency_to_adjacency(A)
% A is sparse B=[0 A;A' 0]
n=size(A,1);
[I J V]=find(A);
B=sparse([I;J+n],[J+n;I],[V;V],2*n,2*n);