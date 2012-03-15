function A=choose_example(n,k,method)
P=[];
no_match=true;
while isempty(P)||no_match
    if method==1
        A=sparse(double(rand(n)<k/n));
    elseif method==2
        A=sparse(n,n);
        for i=1:n
            A(i,:)=chooseKfromN(n,k);
        end
    elseif method==3
        A=regularMatrix(n,k);
    else
        error('invalid method')
    end    
    [P no_match]=bipartite_pfaffian(A);
    if ~isempty(P) && ~no_match && abs(Heperm(A)-abs(det(P)))>1e-12
        disp(':-( something bad happened')
    end
end