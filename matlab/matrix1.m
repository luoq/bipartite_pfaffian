function A=matrix1(k)
% paste k graph G by 4-sum
% G is [1 1 1 0;1 1 0 1;1 0 1 1;0 1 1 1]
X=ones(2);
Y=eye(2);
Xs=cell(k,1);
for i=1:k
    Xs{i}=X;
end
A=sparse([blkdiag(Xs{:}) repmat(Y,k,1);
    repmat(Y,1,k) X]);
end