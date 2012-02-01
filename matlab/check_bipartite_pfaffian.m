function A=check_bipartite_pfaffian
while 1
    A=double(rand(4)<3/4);
    P=bipartite_pfaffian(A);
    if isempty(P)
        continue
    end
    if RNW_perm(A)~=abs(det(P))
        disp('find a wrong example')
        return
    end
end