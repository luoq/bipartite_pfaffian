function B=delete_test(A)
[I J]=find(A);
for k=1:length(I)
    B=A;
    B(I(k),J(k))=0;
    pf=bipartite_pfaffian(B);
    if ~isempty(pf)
        printf('delete edge (%d,%d)\n',I(k),J(k))
        return
    end
end
B=[];