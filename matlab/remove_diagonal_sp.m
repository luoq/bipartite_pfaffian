function B=remove_diagonal_sp(A)
% remove diagonal entries of sparse matrix A
[m n]=size(A);
[I J V]=find(A);
ind=(I~=J);
B=sparse(I(ind),J(ind),V(ind),m,n);