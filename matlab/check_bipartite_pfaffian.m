function A=check_bipartite_pfaffian
while 1
    A=double(rand(4)<3/4);
    P=bipartite_pfaffian(A);
    if isempty(P)
        continue
    end
    if abs(RNW_perm(A)-abs(det(P)))>1e-12
        disp('find a wrong example')
        return
    end
end