function check_pfaffian2(id,k)
if id==1
    %% test 1
    A=generate_matrix1(k);
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 1. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-12
        disp(':-)')
    else
        disp(':-(')
    end
elseif id==2
    %% test 2
    A=generate_matrix1(k);
    A(2*k+1,2*k+1)=0;
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 2. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-12
        disp(':-)')
    else
        disp(':-(')
    end
elseif id==3
    %% test 3
    A=generate_matrix1(k);
    A(2*k+1,2*k+1)=0;
    A(2*k+1,2*k+2)=0;
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 3. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-12
        disp(':-)')
    else
        disp(':-(')
    end
    %% test 4
else
    X1=generate_matrix1(k);
    X2=X1;
    A=glue(X1,[1 2*k+1;1 2*k+1],X2,[1 2*k+1;1 2*k+1]);
    %P=bipartite_pfaffian(A(randperm(size(A,1)),randperm(size(A,1))));
    P=bipartite_pfaffian(A);
    perm=Heperm(A);
    fprintf('test 4. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-8
        disp(':-)')
    else
        disp(':-(')
    end
end
end

function A=generate_matrix1(k)
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

function X=glue(X1,cycle1,X2,cycle2)
n1=size(X1,1);n2=size(X2,1);
mask1_r=false(n1,1);mask1_c=false(n1,1);
mask2_r=false(n2,1);mask2_c=false(n2,1);
mask1_r(cycle1(1,:))=true;mask1_c(cycle1(2,:))=true;
mask2_r(cycle2(1,:))=true;mask2_c(cycle2(2,:))=true;

X=[blkdiag(X1(~mask1_r,~mask1_c),X2(~mask2_r,~mask2_c)) [X1(~mask1_r,mask1_c);X2(~mask2_r,mask2_c)];
    [X1(mask1_r,~mask1_c) X2(mask2_r,~mask2_c)] ones(2)];
end