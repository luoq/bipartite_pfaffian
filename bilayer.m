function q=bilayer(m,n,p,R)
L=grid_graph(m,n);
Color=grid_graph_color_class(m,n);
A=L(Color==1,Color==-1);
B0=blkdiag(A,A');

N=m*n;N1=sum(Color==1);N2=N-N1;
q=zeros(size(p));
for i=1:length(p)
    for j=1:R
        D=sparse(1:N,[N1+(1:N2) 1:N1],rand(1,N)<=p(i));
        B=B0+D;
        q(i)=q(i)+(~isempty(bipartite_pfaffian(B)));
    end
end
q=q/R;