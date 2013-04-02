function B=biadjacency_to_adjacency(A)
% Convert the n*n biadjacency matrix A for a bipartite graph with 2*n vertices 
% to its (2*n)*(2*n) adjacency matrix.
% Namely, convert sparse matrix A to sparse B=[0 A;A' 0]
n=size(A,1);
[I J V]=find(A);
B=sparse([I;J+n],[J+n;I],[V;V],2*n,2*n);