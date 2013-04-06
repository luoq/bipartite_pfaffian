function check_pfaffian2(id,k)
% check the bipartite_pfaffian program
if id==1
    %% test 1
    %% 4-sum of k matrix1, no remove at 4-cycle
    A=matrix1(k);
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 1. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-1
        disp(':-)')
    else
        disp(':-(')
    end
elseif id==2
    %% test 2
    %% 4-sum of k matrix1, remove one edge in 4-cycle
    A=matrix1(k);
    A(2*k+1,2*k+1)=0;
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 2. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-1
        disp(':-)')
    else
        disp(':-(')
    end
elseif id==3
    %% test 3
    %% 4-sum of k matrix1, remove some edges in 4-cycle
    A=matrix1(k);
    A(2*k+1,2*k+1)=0;
    A(2*k+1,2*k+2)=0;
    P=bipartite_pfaffian(A(randperm(2*k+2),randperm(2*k+2)));
    perm=Heperm(A);
    fprintf('test 3. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-1
        disp(':-)')
    else
        disp(':-(')
    end
elseif id==4
    %% test 4
    X1=matrix1(k);
    X2=X1;
    A=foursum(X1,[1 2*k+1;1 2*k+1],X2,[1 2*k+1;1 2*k+1]);
    P=bipartite_pfaffian(A(randperm(size(A,1)),randperm(size(A,1))));
    %P=bipartite_pfaffian(A);
    perm=Heperm(A);
    fprintf('test 4. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-1
        disp(':-)')
    else
        disp(':-(')
    end
else
    X1=matrix1(4);
    X2=matrix1(5);
    X3=X1;
    A=foursum(X1,[1 2*4+1;1 2*4+1],X2,[1 2*5+1;1 2*5+1]);
    A=foursum(X3,[1 2*4+1;1 2*4+1],A,[size(A,1)-1,size(A);size(A,1)-1,size(A)]);
    %P=bipartite_pfaffian(A(randperm(size(A,1)),randperm(size(A,1))));
    P=bipartite_pfaffian(A);
    perm=Heperm(A);
    fprintf('test 4. perm=%d',perm)
    if abs(perm-abs(det(P)))<1e-1
        disp(':-)')
    else
        disp(':-(')
    end
end
end
