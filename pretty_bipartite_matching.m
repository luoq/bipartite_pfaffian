function M=pretty_bipartite_matching(M,n)
% pretty_bipartite_matching(M,n)
% M is the matching in m*2 matrix,n is the size of color class A
% make a matching of bipartite graph more pretty
M=sort(M,2);%make class A always first
M(:,2)=M(:,2)-n;
% [~,permute]=sort(M(:,1));%sort vertices in class A
% M=M(permute,:);