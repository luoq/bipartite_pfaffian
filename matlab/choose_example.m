function A=choose_example(n,k,method)
P=[];
no_match=true;
while isempty(P)||no_match
    if method==1
        A=sparse(double(rand(n)<k/n));
    elseif method==2
        A=sparse(n,n);
        for i=1:n
            A(i,:)=rand_choose(n,k);
        end
    else
        error('invalid method')
    end    
    [P no_match]=bipartite_pfaffian(A);
end