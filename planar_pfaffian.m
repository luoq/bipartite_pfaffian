function pf=planar_pfaffian(G,em0)
% pf=planar_pfaffian(G)
% implement the FKT algorithm (named after Fisher, Kasteleyn, and Temperley)
% G must be connected planar graph and with no vertex of degree 1

global em pf

G=remove_diagonal_sp(G);
if nargin==1
    [is_planar,~,em]=boyer_myrvold_planarity_test(G);
    if(~is_planar)
        error('only planar graph is accepted');
    end
else
    em=em0;
end

pf=2*G;% 2 means the orientation is not determined
% find out tree edges and give weight
[~,~,pred]=bfs(G,1);
for k=2:length(pred) % note 1 is root
    e=sort([k pred(k)]);
    pf(e(1),e(2))=1;
    pf(e(2),e(1))=-1;
end
% find a edge not in tree
[i,j]=find(pf==2,1);
if isempty(i)
    return
end
outer_face=face_cycle(j,i);%find outer face
for k=1:length(outer_face)-1
    if pf(outer_face(k),outer_face(k+1))==2
        face_pfaffian(outer_face(k+1),outer_face(k));
    end
end

function face_pfaffian(i,j)
global pf
face=face_cycle(i,j);
w=1;
for k=2:length(face)-1
    wk=pf(face(k),face(k+1));
    if wk==2
        face_pfaffian(face(k+1),face(k));
        wk=pf(face(k),face(k+1));
    end
    w=w*wk;
end
pf(i,j)=-w;pf(j,i)=w;

function cycle=face_cycle(i,j)
% find the verices on one face of embedding em contains (i,j)
% e(1)==i,e(2)==j,e(end)==i and
% for any k, (e(k),e(k+1)) is after (e(k),e(k-1)) in clockwise
global em
cycle=[i j];
while cycle(end)~=cycle(1)
    u=cycle(end);v=cycle(end-1);
    temp=em.edge_order(em.vp(u):em.vp(u+1)-1);
    ind=find(temp==v);
    if ind==length(temp)
        cycle=[cycle temp(1)];
    else
        cycle=[cycle temp(ind+1)];
    end
end