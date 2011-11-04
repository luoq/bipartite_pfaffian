from graph_tool import Graph
from graph_tool.flow import max_cardinality_matching
from graph_tool.topology import label_components
class BiGraph(Graph):
    def __init__(self):
        """Number of vertices in color class A."""
        super(BiGraph,self).__init__(directed=False) #Note base class must be inited
        self.vertex_name=self.new_vertex_property('object')
        self.num_A=0
    def __init__(self,num_A,n):
        super(BiGraph,self).__init__(directed=False) #Note base class must be inited
        self.vertex_name=self.new_vertex_property('object')
        self.num_A=num_A
        self.add_vertex(n)
        for i in range(self.num_A):
            self.vertex_name[self.vertex(i)]='A'+str(i)
        for i in range(self.num_A,2*self.num_A):
            self.vertex_name[self.vertex(i)]='B'+str(i-self.num_A)
    def permute(self,P):
        B=BiGraph(self.num_A,self.num_vertices())
        for i,j in self.edges():#assume i is in A and j is in B
            B.add_edge(B.vertex(i),B.vertex(P[int(j)-self.num_A]+self.num_A))
        return B
    def contract(self):
        """contract by the perfect matching i->i+num_A,assume it exsits"""
        D=Graph()
        D.add_vertex(self.num_A)
        for i,j in self.edges():
            if int(j)-int(i)!=self.num_A:
                D.add_edge(D.vertex(i),D.vertex(int(j)-self.num_A))
        return D

def graph_to_bigraph(G):
    B=BiGraph(G.num_vertices(),2*G.num_vertices())
    for i,j in G.edges():
        B.add_edge(B.vertex(i),B.vertex(int(j)+B.num_A))
        B.add_edge(B.vertex(j),B.vertex(int(i)+B.num_A))
    return B
    
def bipartite_pfaffian(G):
    """Check if bipartite graph G has a Pfaffian orientation"""

    #check having perfect matching or not
    M,_=max_cardinality_matching(G)
    permutation=range(G.num_A)
    for i in range(G.num_A):
        for e in G.vertex(i).out_edges():
            if M[e]:
                permutation[int(e.target())-G.num_A]=i
                break
        else:
            print "No perfect mathing"
            return False
    #contract by perfectiong matching
    D=G.permute(permutation).contract()
    #reduce to 1-connented digraph
    C,hist=label_components(D,directed=True)
    if hist.size>1:
        for i,j in D.edges():
            if C[i]!=C[j]:
                D.remove_edge(i,j)
    #reduce to 2-connected digraph
    return D
