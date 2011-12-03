function pf=bipartite_pfaffian(A)
% pf=bipartite_pfaffian(G) 
% return half pfaffian of bipartite graph with biadjacent matrix A

n=size(A,1);

%% check existence of perfecting mathing.Contract along it if any
G=biadjacency_to_adjacency(A);
M=matching(G);M=M(1:n)-n; % find a maximal matching
if sum(M>0)<n % no perfect matching
    disp('The permanent is 0')
    pf=sparse(n,n);
    return
end
A=remove_diagonal_sp(A(:,M)); % contract along M

%% convert to strong connected digraph
[c sizes]=components(A);
if length(sizes)==1
    pf=pfaffian1(A);
else % divide and combine multi strong connected digraph
    [~,partition]=sort(c);
    first=1;
    l=length(sizes);
    pfs=cell(1,l);
    for i=1:l
        last=first+sizes(i)-1;
        A1=A(partition(first:last),partition(first:last));
        pfs{i}=pfaffian1(A1);
        if pfs{i}==false
            pf=false;
            return
        end
        first=last+1;
    end
    pf=blkdiag(pfs{:});
    pf(partition,partition)=pf;
end

%% recover from contracted graph
pf=pf-speye(n);% edges of M has weight -1
pf(:,M)=pf;

function pf=pfaffian1(A)
pf=A;