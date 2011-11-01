from graph_tool import Graph
class BiGraph(Graph):
    def __init__(self):
        """ number of vertices in color class A """
        super(BiGraph,self).__init__(directed=False) #Note base class must be inited
        self.num_A=0
        self.vertex_name=self.new_vertex_property('object')
    def from_graph(self,G):
        self.num_A=G.num_vertices()
        self.clear()
        self.add_vertex(2*self.num_A)
        for i,j in G.edges():
            self.add_edge(self.vertex(i),self.vertex(int(j)+self.num_A))
            self.add_edge(self.vertex(j),self.vertex(int(i)+self.num_A))
        for i in range(self.num_A):
            self.vertex_name[self.vertex(i)]='A'+str(i)
        for i in range(self.num_A,2*self.num_A):
            self.vertex_name[self.vertex(i)]='B'+str(i-self.num_A)
