from graph_tool import Graph
def sparse_to_graph(M):
    G=Graph(directed=False)
    G.add_vertex(M.shape[0])
    NI=M.nonzero()
    for i in range(M.nnz):
        G.add_edge(G.vertex(NI[1][i]),G.vertex(NI[0][i]))
    return G
