function check_pfaffian2
k=10;
%% test 1
A=generate_matrix1(k);
P=bipartite_pfaffian(A);
perm=Heperm(A);
fprintf('test 1. perm=%d',perm)
if abs(perm-abs(det(P)))<1e-12
    disp(':-)')
else
    disp(':-(')
end
%% test 2
A(2*k+1,2*k+1)=0;
P=bipartite_pfaffian(A);
perm=Heperm(A);
fprintf('test 2. perm=%d',perm)
if abs(perm-abs(det(P)))<1e-12
    disp(':-)')
else
    disp(':-(')
end
%% test 3
A(2*k+1,2*k+2)=0;
P=bipartite_pfaffian(A);
perm=Heperm(A);
fprintf('test 3. perm=%d',perm)
if abs(perm-abs(det(P)))<1e-12
    disp(':-)')
else
    disp(':-(')
end

end
function A=generate_matrix1(k)
    X=ones(2);
    Y=eye(2);
    Xs=cell(k,1);
    for i=1:k
        Xs{i}=X;
    end
    A=sparse([blkdiag(Xs{:}) repmat(Y,k,1);
        repmat(Y,1,k) X]);
end