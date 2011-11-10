function M=mingreedy(G)
% M=mingreedy(G),G is symmetric
% use mingreedy to get a maximal matching M of G
% mingreedy is proposed in Alan Frieze,A.J. Radcliffe
% Stephen Suen, Analysis of a Simple Greedy Matching Algorithm on
% Random Cubic Graphs

G=remove_diagonal_sp(G);%rempve loops to simplify code
M=[];
n=size(G,1);
vertex=1:n;
condition=true;
while condition
    degree=sum(G,1);
    isolated=(degree==0);
    valid=find(~isolated);
    remove=isolated;
    if(~isempty(valid))
        valid_degree=degree(valid);
        valid=valid(valid_degree==min(valid_degree));
        u=valid(randi(length(valid),1));
        neighbour=find(G(:,u));
        v=neighbour(randi(length(neighbour),1));
        M=[M;vertex(u) vertex(v)];
        remove(u)=true;remove(v)=true;
    end
    G(:,remove)=[];G(remove,:)=[];vertex(remove)=[];
    condition=~isempty(G);
end