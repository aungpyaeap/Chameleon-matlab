# Chameleon Hierarchical Clustering in MATLAB
This repository contains a MATLAB implementation of the **Chameleon** clustering algorithm by [1].

## Files in this Repository
The helper functions and core logic in this repository are adapted from the work of [Kchu/Chameleon-cluster-matlab](https://github.com/Kchu/Chameleon-cluster-matlab).
* `Chameleon.m`: The main entry point for the clustering algorithm.
* `calculEC.m`: Calculates the Internal Interconnectivity (Edge Cut) of a cluster.
* `calculRI.m`: Computes the Relative Interconnectivity between two clusters.
* `calculRC.m`: Computes the Relative Closeness between two clusters.
* `Fowlkes_Mallows_index.m`: An external cluster validity index introduced by [2] to evaluate cluster assignments between generated clusters and ground truth clusters.

## Usage
To run the clustering on your own dataset, you can follow the structure provided in `sample.m`:

```matlab
% Load your data points
load('aggregation.mat');

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

[2] E. B. Fowlkes and C. L. Mallows, "A method for comparing two hierarchical clusterings," *Journal of the American Statistical Association*, vol. 78, no. 383, pp. 553-569, Jun. 1983, doi: [10.1080/01621459.1983.10477908](https://doi.org/10.1080/01621459.1983.10478008).

