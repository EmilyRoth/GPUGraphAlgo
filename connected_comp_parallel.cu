#include <stdio.h>
#include <fstream>
#include <iostream>
#include <stdlib.h>

using namespace std;

__global__ void befriend_adjacents(int* adj_lists, int* sizes, int* labels, int* changed) {
    int id = threadIdx.x;

    // Get start of adj list
    int begin = 0;
    for (int i = 0; i < id; i++) {
        begin += sizes[i];
    }

    int* list = &adj_lists[begin];

    // debug
    // if (sizes[id] == 0) {
    //     debug[id] = -1;
    // } else {
    //     debug[id] = list[0];
    // }

    int min = labels[id];
    for (int i = 0; i < sizes[id]; i++) {
        int adj_label = labels[list[i]];
        if (adj_label < min) {
            min = adj_label;
            *changed = 1;
        }
    }
    labels[id] = min;
}

__global__ void init_labels(int* labels) {
    int id = threadIdx.x;
    labels[id] = id;
}

void print_labels(int* labels, int size) {
    cout << "labels: ";
    for (int i = 0; i < size; i++) {
        cout << labels[i] << " ";
    }
    cout << endl;
}

void print_lists(int* adj_lists, int size, int* list_sizes) {
    cout << "adjacency lists:" << endl;
    int* list = adj_lists;
    for (int i = 0; i < size; i++) {
        cout << "[";
        for (int j = 0; j < list_sizes[i]; j++) {
            cout << " " << list[j] << " ";
        }
        cout << "]" << endl;
        list += list_sizes[i];
    }
}
// void print_debug(int* debug, int size) {
//     cout << "debug: ";
//     for (int i = 0; i < size; i++) {
//         cout << debug[i] << " ";
//     }
//     cout << endl;
// }

// adj_lists is flattened to 1d array
void cc_para(int* adj_lists, int size, int* list_sizes) {
    int* labels = (int*)malloc(size * sizeof(int));
    int* d_labels;

    int list_size_total = 0;
    for (int i = 0; i < size; i++) {
        list_size_total += list_sizes[i];
    }

    cudaMalloc((void**)&d_labels, size * sizeof(int));

    init_labels<<<1, size>>>(d_labels);

    cudaMemcpy(labels, d_labels, size * sizeof(int), cudaMemcpyDeviceToHost);

    int* d_adj_lists;
    cudaMalloc((void**)&d_adj_lists, list_size_total * sizeof(int));
    cudaMemcpy(d_adj_lists, adj_lists, list_size_total * sizeof(int), cudaMemcpyHostToDevice);

    int* d_sizes;
    cudaMalloc((void**)&d_sizes, size * sizeof(int));
    cudaMemcpy(d_sizes, list_sizes, size * sizeof(int), cudaMemcpyHostToDevice);

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

    print_labels(labels, size);

    cudaFree(d_changed); cudaFree(d_labels); cudaFree(d_changed); cudaFree(d_adj_lists);

    free(labels); free(changed);
}

int main() {
    // int * adj_lists[3];
    // int* list0;
    // int list1[1] = {2};
    // int list2[2] = {1}; 
    // adj_lists[0] = list0;
    // adj_lists[1] = list1;
    // adj_lists[2] = list2;
    int adj_lists[4] = {1, 2, 0, 0};

    int size = 4;
    int sizes[4] = {2, 1, 1, 0};

    print_lists(adj_lists, size, sizes);

    cc_para(adj_lists, size, sizes);
}