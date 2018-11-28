import networkx as nx
nodes = int(input("How many nodes? "))
p = float(input("Probability of edge? "))
g = nx.fast_gnp_random_graph(nodes, p)
list_vec = open('rand_graph.list_vec', 'w')
size_vec = open('rand_graph.size_vec', 'w')
count = 0
for line in nx.generate_adjlist(g):
	if(count != 0):
		size_vec.write(",")
	size_vec.write(str(len(line.split(" "))))
	for num in line.split(" "):
		if(count != 0):
			list_vec.write(",")	
		list_vec.write(str(num))
		count+=1

list_vec.write('\n')
size_vec.write('\n')
list_vec.close()
size_vec.close()
