function res=diag_test(A,R,seed)
rng(seed)
n=size(A,1);
G=biadjacency_to_adjacency(A);
M=matching(G);M=M(1:n)-n; % find a maximum matching
if sum(M>0)<n % no perfect matching
    disp('trival:no perfect matching')
    return
end
A=A(:,M); % permute so we have 1 in diagonal
A0=remove_diagonal_sp(A);

I=1:n;J=1:n;
parfor i=1:R
    fprintf('----\n')
    x=rand(1,n);
    [~, order]=sort(x);
    low=1;high=n; % low statisfy P, high+1 not satisfy P(?)
    while low~=high
        j=ceil((low+high)/2);
        mask=x<x(order(j));
        pf = bipartite_pfaffian(A0+sparse(I(mask),J(mask),1,n,n));
        if isempty(pf)
            high=j-1;
        else
            low=j;
        end
    end
    n_star(i)=low;
    p_star(i)=x(order(low));
end
res=[n_star' p_star'];