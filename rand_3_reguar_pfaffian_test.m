n=30;
d=3;
N=1000;
C=0;
for i=1:N
    disp(i)
    pf=bipartite_pfaffian(regularMatrix(n,d));
    if ~isempty(pf)
        C=C+1;
    end
end