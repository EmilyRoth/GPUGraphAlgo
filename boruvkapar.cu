#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <map>
#include <vector>

using namespace std;

class Edge {
	int src, dest, val;
}

class Graph {
	int V, E;
	Edge* edges;
}

class Segment {
	int rep;
	int rank;
	vector<Edge> adjList;
}

map<int, Segment*> segmentOwner;
vector<Segment*> segments;

void populateSegments(vector<Edge> edges) {
	for(vector<Edge>::iterator it = edges.begin(); it != edges.end(); ++it) {
		Segment* seg;
		if (segmentOwner.find(it->src) == segmentOwner.end()) {
			seg = new Segment();
		} else {
			seg = segmentOwner[it->src]
		}
		seg->adjList.push_back(*it);
		segmentOwner[it->src] = seg;
		if (segmentOwner.find(it->dest) == segmentOwner.end()) {
			seg = new Segment();
		} else {
			seg = segmentOwner[it->src]
		}
		seg->adjList.push_back(*it);
		segmentOwner[it->src] = seg;
	}
}

void boruvkaParallel(vector<Edge> edges) {
    int V = graph->V, E = graph->E;

    populateSegments(edges)

    int *cheapest = new int[]
}