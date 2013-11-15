function result=laplace_expansion_test(A,k)
n=size(A,1);
C = combnk(1:n,k);
result=zeros(size(C,1),2);
for i=1:size(C,1)
    sprintf('%d of %d:',i,size(C,1))
    mask1=C(i,:);
    for j=1:size(C,1);
        sprintf('%d of %d: %d %d',j,size(C,1),result(i,1),result(i,2))
        mask2 = C(j,:);
        if RNW_perm(A(mask1,mask2))>0
            result(i,1)=result(i,1)+1;
            X=A;
            X(mask1,:)=[];X(:,mask2)=[];
            if ~isempty(bipartite_pfaffian(X))
                result(i,2)=result(i,2)+1;
            end
        end
    end
end