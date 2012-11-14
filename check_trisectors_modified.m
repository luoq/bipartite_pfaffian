function check_trisectors_modified
while 1
    A=double(rand(30)<6/30);
    G=biadjacency_to_adjacency(A);
    tic
    T1=trisectors_modified(G);
    toc
    tic
    T2=trisectors_modified_brute(G);
    toc
    if ~isempty(setdiff(T1,T2,'rows'))
        error('trisectors_modified fail!')
        return
    else
        disp(':-)')
    end
end