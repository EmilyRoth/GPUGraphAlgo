#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>

__global__ void befriend_adjacents(int** adj_lists, int* sizes, int* labels, int* changed) {
    int id = threadIdx.x;
    int* list = adj_lists[id];
    int min = labels[id];
    for (int i = 0; i < sizes[id]; i++) {
        int adj_label = labels[list[i]]
        if (adj_label < min) {
            min = adj_label;
            *changed = 1;
        }
    }
    labels[id] = min;
}

__global__ void init_labels(int* labels) {
    int id = threadIdx.x;
    label[id] = id;
}

void cc_para(int** adj_lists, int size, int* list_sizes) {
    int* labels = (int*)malloc(size * sizeof(int));
    int* d_labels;
    cudaMalloc((void**)&d_labels, size * sizeof(int));

    init_labels<<<1, size>>>(d_labels)

    int** d_adj_lists;
    cudaMalloc((void**)&d_adj_lists, size * sizeof(int*));
    for (int i = 0; i < size; i++) {
        cudaMalloc((void**)d_adj_lists[i], list_sizes[i] * sizeof(int));
        cudaMemcpy(*(&d_adj_lists[i]), &adj_lists[i], list_sizes[i] * sizeof(int), cudaMemcpyHostToDevice);
    }
    int* d_sizes;
    cudaMalloc((void**)&d_sizes, size * sizeof(int));
    cudaMemcpy(d_sizes, sizes, size * sizeof(int), cudaMemcpyHostToDevice);

    int* changed = (int*)malloc(sizeof(int));
    int* d_changed;
    cudaMalloc((void**)&d_changed, sizeof(int));
    *changed = 1;

    while (*changed != 0) {
        *changed = 0;
        cudaMemcpy(d_changed, changed, sizeof(int), cudaMemcpyHostToDevice);

        befriend_adjacents<<<1, size>>>(d_adj_lists, d_sizes, d_labels, d_changed);

        cudaMemcpy(changed, d_changed, sizeof(int), cudaMemcpyDeviceToHost);
    }

    cudaMemcpy(labels, d_labels, size * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < size; i++) {
        cudaFree(d_adj_lists[i]);
    }
    cudaFree(d_changed); cudaFree(d_labels); cudaFree(d_changed); cudaFree(d_adj_lists);

    free(labels); free(changed);
}

int main() {

}