#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include "test.h"

using namespace std;

int main(){

	// make an undirected and connected graph
	// remember n is vertices and m is edges
	cout << "hello world";
	FILE* pFile = fopen("input.txt", "r");
	if(pFile == NULL){
		cout << "Fam u can't do that stop";
		return 0;
	}
	
	// read in first line with n and m
	int n, m;
	fscanf(pFile, "%d %d", &n, &m);
	cout << "Settings: " << n << " " << m << endl;
	int adj_mat[n][n];

	struct graph* g = createGraph(n, m);

	// iterate thru all edges
	for(int i = 0; i<m; i++){
		int n1, n2, weight;
		fscanf(pFile, "%d %d %d", &n1, &n2, &weight);

		// adjecency list nonsense
		adj_mat[n1][n2] = weight; // put that node in
		adj_mat[n2][n1] = weight; //gotta put it in for both

		// disjoint unions
		// TODO check the dereference
		addEdge(&(g.edge[i]), n1, n2, weight);
	} 

	// adjacency graph built now it's dumb lit
	// okay fam lets get this bread with the normal sequential algorithm


	return 0;
}

// a constructor in cpp??
struct graph* createGraph(int V, int E) {
	graph* g = new graph;
	g->V = V;
	g->E = e;
	g->edge = new edge[E];
	return g;
}

// finds the set of an element
// TODO need to do more research on disjoint unions to know what that means
int find(struct subset subsets[], int i) {
	// path compression??
	// TODO find root and make root parent of i what
	if(subsets[i].parent != i) {
		subsets[i].parent = find(subsets, subsets[i].parent);
	}
	return subsets[i].parent;
}

// does the union of two sets of x and y
// (definition of above: Union by Rank)
// TODO what is union by rank
void Union(struct subset subsets[], int x, int y) {
	int xroot = find(subsets, x);
	int yroot = find(subsets, y);

	// attach smaller rank tree under the root of the high rank tree
	if (subsets[xroot].rank < subsets[yroot].rank) {
		subsets[xroot].parent = yroot;
	} else if (subsets[xroot].rank > subsets[yroot].rank) {
		subsets[yroot].parent = xroot;
	} else {
		// if ranks are equal, make x root and increment rank by one
		// TODO why increment rank by 1 only? what is rank?
		subsets[yroot].parent = xroot;
		subsets[xroot].rank++;
	}
}

void addEdge(edge* e, int src, int dest, int weight) {
	e.src = src;
	e.dest = dest;
	e.weight = weight;
}

void primMST(int graph[][]) {

}

void printMST(int n, int graph[][], int parent[]){
	cout << " Edge \t Weight\n";
	for(int i = 1)
}

void babushkaMST(struct graph* graph) {
	int V = g->V;
	int E = g->E;
	edge *e = graph.edge;

	//allocate memory for creating V subsets
	// TODO what is a subset
	// Michael, what. does a bean mean?
	struct subset *subsets = new subset[V];

	//stores the cheapest edge of each subset
	int *cheapest = new int[V];

	// create V subsets with single elements
	for (int v = 0; v < V; ++v) {
		subsets[v].parent = v;
		subsets[v].rank = 0;
		cheapest[v] = -1;
	}

}