import scipy.io
from util import *
F30=scipy.io.loadmat('../matrix/F30.mat')['F30']
G=sparse_to_graph(F30)
