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
		segments.push_back(seg);
		if (segmentOwner.find(it->dest) == segmentOwner.end()) {
			seg = new Segment();
		} else {
			seg = segmentOwner[it->src]
		}
		seg->adjList.push_back(*it);
		segmentOwner[it->src] = seg;
		segments.push_back(seg);
	}
}

void boruvkaParallel(vector<Edge> edges) {
    int V = graph->V, E = graph->E;

	populateSegments(edges)
	
	int numSegments = segments.size();

	int *cheapest = new int[numSegments];
	
	// TODO: Start loop
		// Iterate over segments (one thread each)
		// Add cheapest edge to mst
		// Set owner to the segment of the lower index member (atomic)
		// Merge adjacency lists
		// Get rid of old segments
		// Update numSegments
}