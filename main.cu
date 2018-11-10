#include <stdio.h>
#include <fstream>

int main(int argc, char **argv){

	// make an undirected and connected graph
	// remember n is vertices and m is edges
	FILE* pFile = fopen("input.txt", "r")
	if(ptr == NULL){
		printf("No such file fam wyd");
		return 0;
	}
	// read in first line with n and m
	int n, m;
	fscanf(pFile, "%d %d", &n, &m);
	printf("%d %d\n", n, m);
	int adj_mat[n][n]; // idk what values we want but I'm starting with 4 nodes

	// iterate thru all edges
	for(int i = 0; i<m; i++){
		int n1, n2, weight;
		fscanf(pFile, "%d %d %d", &n1, &n2, &weight);
		adj_mat[n1][n2] = weight; // put that node in
		printf("%d\n", adj_mat[n1][n2]);
	}

	return 0;
}