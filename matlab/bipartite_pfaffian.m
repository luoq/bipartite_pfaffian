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
l=length(sizes);
if l==1
    pf=pfaffian1(A);
    if isempty(pf)
        return
    end
else % divide and combine multi strong connected digraph
    [~,partition]=sort(c);
    first=1;
    pfs=cell(1,l);
    for i=1:l
        last=first+sizes(i)-1;
        A1=A(partition(first:last),partition(first:last));
        pfs{i}=pfaffian1(A1);
        if isempty(pfs{i})
            pf=[];
            return
        end
        first=last+1;
    end
    pf=blkdiag(pfs{:});
    pf(partition,partition)=pf;
end

%% recover from contracted graph
pf(:,M)=pf;
end

function pf=pfaffian1(A)
% convert problem of 1-strongly-connected graph to 2-strongly-connected graph
n=size(A,1);
pf=pfaffian1_helper(A,true(1,n));
end

function pf=pfaffian1_helper(A,not_checked)
n=size(A,1);
v=find(not_checked,1);
% already 2-strongly-connected
if(isempty(v))
    pf=pfaffian2(A);
    return
end
not_checked(v)=false;
Am=minor(A,v);
[c,sizes]=components(Am);
l=length(sizes);
if l>1 % handle reducing case
    % build components mapping
    [~,partition]=sort(c);
    mask=(partition>=v);%leave index v for v
    partition(mask)=partition(mask)+1;
    
    pfs=cell(1,l);
    weight1=zeros(n,1);
    weight2=zeros(n,1);
    first=1;
    for i=1:l
        last=first+sizes(i)-1;
        % build up submatrix mask
        mask=false(n,1);mask(partition(first:last))=true;
        Internal=A(mask,mask);
        % build up subgraph
        A2=[Internal sum(A(mask,~mask),2)>0;sum(A(~mask,mask),1)>0 0];
        pfs{i}=pfaffian1_helper(A2,[not_checked(mask) false]);
        if(isempty(pfs{i}))
            pf=[];
            return
        end
        % save cross vertices info
        % NOTE:weight1 and weight1 are dependent.In fact
        % weight1(v)=-weight2(v),if both values are recorded,
        weight1(mask)=pfs{i}(end,1:end-1);
        weight2(mask)=pfs{i}(1:end-1,end);
        pfs{i}=pfs{i}(1:end-1,1:end-1);
        first=last+1;
    end
    %% restore original weights
    pf=blkdiag(pfs{:},0);
    partition=[partition;v];% add v in permutation
    pf(partition,partition)=pf;
    pf(v,:)=weight1'.*A(v,:);% edges from v,not hard to see the value recored
    pf(:,v)=weight2.*A(:,v);% edges to v,not hard to see the value recored
    pf(v,v)=-1;% edges in perfect matching always get -1
    % weighting cross edges
    map=[c(1:v-1);0;c(v:end)];
    [I J]=find(A);
    mask=((map(I)~=map(J)) & (map(I)~=0) & (map(J)~=0));
    I=I(mask);J=J(mask);
    % It's easy to see for cross edge (u,v),weight2(u) and weight1(v) must
    % be recorded before.But the reverse is not true.
    V=-weight1(J).*weight2(I);
    pf=pf+sparse(I,J,V,n,n);
else % handle non reducing case
    pf=pfaffian1_helper(A,not_checked);
end
end

function pf=pfaffian2(A)
global Heawood
% handle 2-strongly-connected graph
A=A+speye(size(A,1));
B=biadjacency_to_adjacency(A);
n=size(A,1);
if n>=3 && nnz(A)>2*(2*n)-4
    disp('No possible pfaffian orientation')
    pf=[];
    return
elseif 2*n<=4 % B must be planar
     [~,~,embedding]=boyer_myrvold_planarity_test(B);
     pf=planar_pfaffian(B,embedding);
     pf=pf(1:n,n+1:2*n);
elseif n==7 && nnz(A)==21 && ...
        graphisomorphism(B,biadjacency_to_adjacency(Heawood),'Directed',false)
    pf=-A;
    return
else
    T=trisectors(B);
    pf=pfaffian2_helper(B,T);
    if isempty(pf)
        return
    end
    pf=pf(1:n,n+1:2*n);
end
% edges of M has weight -1
pf=-diag(diag(pf))*pf;
end

function pf=pfaffian2_helper(B,T)
n=size(B,1);
[is_planar,~,embedding]=boyer_myrvold_planarity_test(B);
if(is_planar)
    pf=planar_pfaffian(B,embedding);
elseif isempty(T)
    disp('can not be expressed as trisum of planar brace')
    pf=[];
    return
elseif size(T,1)>n-5
    disp('too much trisectors')
    pf=[];
    return
else
    error('not implemented')
end
end