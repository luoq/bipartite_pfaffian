from graph_tool.all import *
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
        B=BiGraph()
        B.num_A=self.num_A
        B.add_vertex(self.num_vertices())
        for i,j in self.vertices():#assume i is in A and j is in B
            pass
def graph_to_bigraph(G):
    B=BiGraph(G.num_vertices(),2*G.num_vertices())
    for i,j in G.edges():
        B.add_edge(B.vertex(i),B.vertex(int(j)+B.num_A))
        B.add_edge(B.vertex(j),B.vertex(int(i)+B.num_A))
    return B
    
def bipartite_pfaffian(G):
    """Check if bipartite graph G has a Pfaffian orientation"""
    M,_=max_cardinality_matching(G)
    permutation=range(G.num_A)
    for i in range(G.num_A):
        for e in G.vertex(i).out_edges():
            if M[e]:
                permutation[i]=int(e.target())
                break
        else:
            print "No perfect mathing"
            return False
    return permutation
