function pf=bipartite_pfaffian(A)
% pf=pfaffian(G) 
% return half pfaffian of bipartite graph with biadjacent matrix A
n=size(A,1);
G=biadjacency_to_adjacency(A);
M=matching(G);M=M(1:n)-n; % find a maximal matching
if nnz(M)<n % no perfect matching
    pf=sparse(n,n);
end
A=remove_diagonal_sp(A(:,M)); % contract along M