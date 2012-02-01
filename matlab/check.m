function check
check_planar_pfaffian
check_trisectors

function check_trisectors
G0=grid_graph(3,3);
n=size(G0,1);
X=[1 2 4 5];
Y=setdiff(1:n,X);
G=blkdiag(G0(X,X),G0(Y,Y),G0(Y,Y),G0(Y,Y));
G(1:4,5:end)=repmat(G0(X,Y),1,3);
G(5:end,1:4)=repmat(G0(Y,X),3,1);
T1=trisectors(G);
T2=trisectors_brute(G);
if ~isempty(setdiff(T1,T2,'rows'))
    error('trisectors fail!')
end
disp('trisectors :-)');

function check_planar_pfaffian
[A xy]=grid_graph(8,8);
pf=planar_pfaffian(A);
figure
gplot(triu(pf)==1,xy,'r');hold on;gplot(triu(pf)==-1,xy,'b');hold off
if abs(sqrt(det(pf))-12988816)>1e-6
    error('planar_pfaffian fail!')
end
disp('planar_pfaffian :-)')