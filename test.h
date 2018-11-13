struct edge {
	int src, dest, weight;
};

struct graph {
	// V: number of vertices
	// E: number of edges
	int V, E;

	// The graph is an array of edges
	Edge* edge;
};

// Disjoint Union
struct subsets {
	int parent, rank;
};

int find(struct subset subsets[], int i);
void Union(struct subset subsets[], int x, int y);
void babuchkaMST(struct graph* graph);