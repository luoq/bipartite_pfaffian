function res=bilayer_test(m,n,R)
L=grid_graph(m,n);
Color=grid_graph_color_class(m,n);
A=L(Color==1,Color==-1);
B0=blkdiag(A,A');
N=m*n;N1=sum(Color==1);N2=N-N1;

res=zeros(R,2);
I=1:N;
J=[N1+(1:N2) 1:N1];
for i=1:R
    x=rand(1,N);
    [~, order]=sort(x);
    low=1;high=N; % low statisfy P, high+1 not satisfy P(?)
    while low~=high
        j=ceil((low+high)/2);
        mask=x<x(order(j));
        pf = bipartite_pfaffian(B0+sparse(I(mask),J(mask),1,N,N));
        if isempty(pf)
            high=j-1;
        else
            low=j;
        end
    end
    res(i,1)=low;res(i,2)=x(order(low));
end