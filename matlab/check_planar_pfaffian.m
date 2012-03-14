function check_planar_pfaffian
[A xy]=grid_graph(8,8);
pf=planar_pfaffian(A);
figure
gplot(triu(pf)==1,xy,'r');hold on;gplot(triu(pf)==-1,xy,'b');hold off
if abs(sqrt(det(pf))-12988816)>1e-6
    error('planar_pfaffian fail!')
end
disp('planar_pfaffian :-)')