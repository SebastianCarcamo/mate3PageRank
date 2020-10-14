import networkx as nx
import matplotlib.pyplot as plt
import string
from csv import reader
from networkx.drawing.nx_agraph import graphviz_layout
import os
from matplotlib.pyplot import figure, text

letters = string.ascii_lowercase


def readCsv(name):
	with open(name, 'r') as f:
		csv_reader = reader(f)
		list_of_rows = list(csv_reader)
		v = list_of_rows[:][len(list_of_rows)-1]
		del list_of_rows[-1]
		return [list_of_rows,v]

def getEdges(M):
	edgeList = []
	for i in range(len(M)):
		for j in range(len(M)):
			if M[i][j] == 1 or M[i][j] == "1":
				edgeList.append([letters[j],letters[i]])
	return edgeList


matrices = os.listdir("./matrices")

print("Escoge la matriz a usar:")

for i in range(len(matrices)):
	print("{}. {}".format(i+1, matrices[i]))

file = int(input())


name = matrices[file-1]
m,v = readCsv("./matrices/" + name)


v = [(1000*float(x))**2 for x in v]
names = [letters[x] for x in range(len(m))]

edges = getEdges(m)

G = nx.DiGraph()
G.add_nodes_from(names)
G.add_edges_from(edges)

pos = nx.spring_layout(G)
nx.draw(G,pos, node_size = v, arrowsize = 25)

for node, (x, y) in pos.items():
    text(x, y, node, fontsize=40, ha='center', va='center')

figure = plt.gcf()
figure.set_size_inches(25,20)

name = name[:-4]
plt.savefig('./imgs/' + name + '.png', transparent = True)

print("Imagen guardada en el folder imgs")

plt.show()