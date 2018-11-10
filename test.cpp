#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>

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
	int adj_mat[n][n]; // idk what values we want but I'm starting with 4 nodes
	// iterate thru all edges
	for(int i = 0; i<m; i++){
		int n1, n2, weight;
		fscanf(pFile, "%d %d %d", &n1, &n2, &weight);
		adj_mat[n1][n2] = weight; // put that node in
		adj_mat[n2][n1] = weight; //gotta put it in for both
	} 

	// adjacency graph built now it's dumb lit
	// okay fam lets get this bread with the normal sequential algorithm


	return 0;
}

void primMST(int graph[][]){

}

void printMST(int n, int graph[][], int parent[]){
	cout << " Edge \t Weight\n";
	for(int i = 1)
}