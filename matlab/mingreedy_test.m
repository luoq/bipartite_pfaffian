A=toMatlab(dlmread('test.data','',6,0));
n=size(A,1);
B=biadjacency_to_adjacency(A);
if max(components(B))>1
    disp graph is degenerated
    break
end
% drawNetwork(B);
while 1
    M=mingreedy(B);
    if(size(M,1)~=n)
        M
        break
    end
end