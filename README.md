# Chameleon Hierarchical Clustering in MATLAB
This repository contains a MATLAB implementation of the **Chameleon** clustering algorithm by [1].

## Algorithm Steps
1.  **K-Nearest Neighbor Graph**: Represents the data points as a graph where edges exist between a point and its $k$ most similar neighbors.
2.  **Graph Partitioning**: Partitions the $k$-NN graph into many small sub-clusters (initial seeds) using spectral clustering.
3.  **Agglomerative Hierarchical Merging**: Repeatedly merges sub-clusters that share high **Relative Interconnectivity (RI)** and **Relative Closeness (RC)**.

## Files in this Repository
The helper functions and core logic in this repository are adapted from the work of [Kchu/Chameleon-cluster-matlab](https://github.com/Kchu/Chameleon-cluster-matlab).
* `Chameleon.m`: The main entry point for the clustering algorithm.
* `calculEC.m`: Calculates the Internal Interconnectivity (Edge Cut) of a cluster.
* `calculRI.m`: Computes the Relative Interconnectivity between two clusters.
* `calculRC.m`: Computes the Relative Closeness between two clusters.
* `Fowlkes_Mallows_index.m`: An evaluation metric to compare the clustering result against ground truth labels.
* `sample.m`: A demonstration script that loads data, runs the algorithm, and plots the results.

## Usage
To run the clustering on your own dataset, you can follow the structure provided in `sample.m`:

```matlab
% Load your data points
load('aggregation.mat'); % Should contain 'points' and 'labels'

% Run Chameleon Clustering
[clusters, K] = Chameleon(points);

% Evaluate clustering quality using Fowlkes-Mallows Index
fmi_score = Fowlkes_Mallows_index(clusters, labels);
fprintf('FMI score: %.4f\n', fmi_score);

% Visualize results
figure;
gscatter(points(:,1), points(:,2), clusters);
title(['Chameleon Clustering Result (K=' num2str(K) ')']);
```

## Reference
[1] G. Karypis, Eui-Hong Han, and V. Kumar, "Chameleon: hierarchical clustering using dynamic modeling," *Computer*, vol. 32, no. 8, pp. 68-75, Aug. 1999. doi: [10.1109/2.781637](https://ieeexplore.ieee.org/abstract/document/781637).