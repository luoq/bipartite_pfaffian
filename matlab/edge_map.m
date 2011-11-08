function map=edge_map(G)
% map=edge_map(G)
% i-th row of map is the source and target of the edge of G with index i in
% MatlabBGL
[I J]=find(G);
[I perm]=sort(I);%assume sort is stable
map=[I J(perm)];