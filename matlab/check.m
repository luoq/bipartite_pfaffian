function check
A=grid_graph(8,8);
if abs(sqrt(det(planar_pfaffian(A)))-12988816)>.1
    error('planar_pfaffian fail!')
end
disp('All Right')