function count=diag_delete_test(A,k)
n=size(A,1);
G=biadjacency_to_adjacency(A);
M=matching(G);M=M(1:n)-n; % find a maximum matching
if sum(M>0)<n % no perfect matching
    disp('trival:no perfect matching')
    return
end
A=A(:,M); % permute so we have 1 in diagonal

count=0;
C = combnk(1:n,k);
for j=1:size(C,1)
    sprintf('%d of %d: %d',j,size(C,1),count)
    mask = C(j,:);
    X=A;
    for l=mask
        X(l,l)=0;
    end
    if ~isempty(bipartite_pfaffian(X))
        count=count+1;
    end
end
