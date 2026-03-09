function [finalLabels, K] = Chameleon(points)

% ---------------- Chameleon Parameters ----------------

[n, ~] = size(points);
k = 2*log(n);           % Number of nearest neighbors used to construct the k-NN graph.
npart = 7;              % Expected number of clusters.
alpha = 2.0;            % Relative importance between inter-connectivity (RI).
minMatrix = 0.05;       % Merge threshold controlling when clusters should merge.

numNode = size(points,1);
Weight = zeros(numNode,numNode);
partCluster = cell(npart, 1);

%% Set up weight (distance) matrix
dist = pdist2(points, points, "euclidean");
dist = dist - diag(diag(dist));
tempWeight =exp(-dist.^2);

%% Connect the nearest k node
[~,index] = sort(tempWeight,2,'descend');
for p=1:numNode
    for q=1:k
        Weight(p,index(p,q))=tempWeight(p,index(p,q));
    end
end
Weight= max(Weight, Weight');

%% Partition the Graph
partitionLabels = spectralcluster(Weight, npart,'Distance','precomputed');
for r = 1:numNode
    clusterIdx = partitionLabels(r);
    partCluster{clusterIdx} = [partCluster{clusterIdx} r];
end

%% Merge the similar cluster
mergeCluster = partCluster;
change = true;
while change
    change = false;
    for i=1:npart-1
        if isempty(mergeCluster{i})
            continue;
        end
        for j=i+1:npart
            if isempty(mergeCluster{j})
                continue;
            end
            ri = calculRI(mergeCluster{i}, mergeCluster{j}, Weight);
            rc = calculRC(mergeCluster{i}, mergeCluster{j}, Weight);
            if ri*(rc^alpha) > minMatrix
                mergeCluster{i} = [mergeCluster{i} mergeCluster{j}];
                mergeCluster{j} = [];
                change = true;
            end
        end
    end
end

%% Extract Final Cluster Labels
finalLabels = zeros(numNode, 1);
clusterID = 1;

for i = 1:npart
    if ~isempty(mergeCluster{i})
        finalLabels(mergeCluster{i}) = clusterID;
        clusterID = clusterID + 1;
    end
end

K = clusterID - 1;
fprintf('Number of clusters: %d\n', K);

end