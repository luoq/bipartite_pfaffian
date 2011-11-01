import scipy.io
from polya import *
from graph_tool.all import *
from util import *
F30=scipy.io.loadmat('../matrix/F30.mat')['F30']
G=sparse_to_graph(F30)
#graph_draw(G,size=(20,20),vsize=0.5,vprops={'label':G.vertex_index,'fixedsize':True},output='G30.png')
BG=graph_to_bigraph(G)
#graph_draw(BG,size=(20,20),vsize=0.5,vprops={'label':BG.vertex_name,'fixedsize':True},output='BG30.png')
D=bipartite_pfaffian(BG)
graph_draw(D,size=(20,20),vsize=0.5,vprops={'label':D.vertex_index,'fixedsize':True},output='D30.png')
