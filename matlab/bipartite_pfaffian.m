function [pf no_match]=bipartite_pfaffian(A)
% pf=bipartite_pfaffian(G) 
% return half pfaffian of bipartite graph with biadjacent matrix A

save '/tmp/tmp.mat' A
no_match=false;
n=size(A,1);

%% check existence of perfecting mathing.Contract along it if any
G=biadjacency_to_adjacency(A);
M=matching(G);M=M(1:n)-n; % find a maximal matching
if sum(M>0)<n % no perfect matching
    disp('The permanent is 0')
    pf=sparse(n,n);
    no_match=true;
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
    pf(v,:)=weight1'.*A(v,:);% edges from v,not hard to see the value exists
    pf(:,v)=weight2.*A(:,v);% edges to v,not hard to see the value exists
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
n=size(A,1);N=2*n;
if N>=3 && nnz(A)>2*N-4
    disp('No possible pfaffian orientation by 7.3')
    pf=[];
    return
elseif N<=4 % B must be planar
     [~,~,embedding]=boyer_myrvold_planarity_test(B);
     pf=planar_pfaffian(B,embedding);
     pf=pf(1:n,n+1:2*n);
elseif n==7 && nnz(A)==21 && ...
        graphisomorphism(B,biadjacency_to_adjacency(Heawood),'Directed',false)
    pf=-A;
    return
else
    [is_planar,~,embedding]=boyer_myrvold_planarity_test(B);
    if(is_planar)
        pf=planar_pfaffian(B,embedding);
    else
        T=trisectors_modified(B);
        if isempty(T);
            pf=[];
            return
        end
        T(:,3:4)=T(:,3:4)-n;%shit index of class B
        pf=pfaffian2_helper(A,T);
        if isempty(pf)
            return
        end
    end
end
% edges of M has weight -1
pf=-diag(diag(pf))*pf;
end

function pf=pfaffian2_helper(A,T)
n=size(A,1);
%If function is called recursively,the X_{n-1},Y_{n-1},X_n:Y_n are the 4-cycle
B=biadjacency_to_adjacency(A);
[is_planar,~,embedding]=boyer_myrvold_planarity_test(B);
if(is_planar)
    pf=planar_pfaffian(B,embedding);
    if isempty(pf)
        return
    end
    pf=pf(1:n,n+1:2*n);
    if n>2 && A(n-1,n-1) && A(n-1,n) && A(n,n-1) && A(n,n)
        % result may be combined,orient it coordinately
        % the circle C X_{n-1},Y_{n-1},X_n:Y_n must be evenly oriented
        % convert it to X_{n-1} --> Y_{n-1} <--X_n <-- B_n <--- 
        if pf(n-1,n-1)~=1
            pf(n-1,:)=-pf(n-1,:);
        end
        if pf(n,n-1)~=1
             pf(:,n-1)=-pf(:,n-1);
        end
        if pf(n,n)~=-1
             pf(n,:)=-pf(n,:);
        end
        % now pf(n-1,n) must be 1 because if the function is called recursively
        % then C must be oddly oriented
    end
elseif isempty(T)
    disp('can not be expressed as trisum of planar brace')%empty T and not planar
    pf=[];
    return
elseif size(T,1)>2*n-5
    disp('too much trisectors by 8.9')
    pf=[];
    return
else
    t=T(1,:);
    T=T(2:end,:);
    
    B_minor=minor(B,[t(1:2) t(3:4)+n]);
    [c,sizes]=components(B_minor);

    mask=false(2*n,1);mask([t(1:2) t(3:4)+n])=true;
    label=zeros(2*n,1);label(~mask)=c;
    l=length(sizes);%l>=3
    label(mask)=l+1;
    label_r=label(1:n);label_c=label(n+1:2*n);
    [~,partition_r]=sort(label_r);
    [~,partition_c]=sort(label_c);
    
    %compute the map from old index to index in component
    old2new_r=zeros(n,1);old2new_c=zeros(n,1);
    %The new index of vetices of C is negative to distinguish
    %value for other componets are computed when needed
    old2new_r(label_r==l+1)=(-1):0;old2new_c(label_c==l+1)=(-1):0;
     
    % compute the component of each trisector
    if ~isempty(T)
        label_T=[label_r(T(:,1:2)) label_c(:,3:4)];
        n_T=size(T,1);
        for i=1:n_T
            % Each trisector must have label>0 and this number is fixed by 8.6
            label_T(i,1)=label_T(i,find(label_T(i,1)>0,1));
        end
        label_T=label_T(:,1);
    end
 
    %divide and combine
    pfs=cell(l,1);
    ns=sizes/2;
    cross_r=pfs;cross_c=pfs;
    first=1;
    for i=1:l
        last=first+ns(i)-1;
        Ai=A([partition_r(first:last);t(1);t(2)],[partition_c(first:last);t(3);t(4)]);
        Ai(end-1:end,end-1:end)=ones(2);
        
        if ~isempty(T)
            Ti=T(label_T==i,:);
            %compute the old2new map for component i
            old2new_r(label==i)=1:ns(i);
            old2new_c(label==i)=1:ns(i);
            Ti=[old2new_r(Ti(:,1:2)),old2new_c(Ti(:,3:4))];
            i_mask=(Ti<=0);
            Ti(i_mask)=Ti(i_mask)+(ns{i}+2);
            Ti(:,1:2)=sort(Ti(:,1:2),2);
            Ti(:,3:4)=sort(Ti(:,3:4),2);
        else
            Ti=[];
        end
        
        pfs{i}=pfaffian2_helper(Ai,Ti);
        if isempty(pfs{i})
            pf=[];
            return
        end
        cross_r{i}=pfs{i}(ns(i)-1:ns(i),1:ns(i)-2);
        cross_c{i}=pfs{i}(1:ns(i)-2,ns(i)-1:ns(i));
        pfs{i}=pfs{i}(1:ns(i)-2,1:ns(i)-2);
    end
    % The pfaffian orientation of four cycle
    C=[1 1;1 -1];
    C(A(t(1:2),t(3:4))==0)=0;
    % construct result
    pf=[blkdiag(pfs{:}) vertcat(cross_c{:});
        horzcat(cross_r{:}) C];
    pf(partition_r,partition_c)=pf;
end
end