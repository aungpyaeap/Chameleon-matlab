clc; clear; close all;

load aggregation.mat;

[clusters, K] = Chameleon(points);

fmi_score = Fowlkes_Mallows_index(clusters,labels);
fprintf('FMI score: %.4f\n', fmi_score);

figure;
gscatter(points(:,1), points(:,2), clusters, lines(K), '.', 16);
title('Chameleon Clustering Result');
xlabel('Feature 1');
ylabel('Feature 2');
grid on;