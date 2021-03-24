function plotkclusteringtypes(snapshotList)
% clears the previous figure
clf

% intialisation of sum of centroids, zeros in 8 by 2 matrix
sum_of_centroids3 = zeros(8, 2);
sum_of_centroids6 = zeros(8, 2);
sum_of_centroids8 = zeros(8, 2);

% loop over the entire snapshotList
for i = 1:length(snapshotList)
    hold on % comment out to enable an animation of the points over snapshotList
    
    % puts data in matrix for k-median clustering algorithm
    matrix = [snapshotList{i}.xmm,snapshotList{i}.ymm];
    
    % different k-medians distancing methods + observations for each
    %[idx1, C1] = kmedoids(matrix, 8, 'Distance','sqEuclidean'); % sometimes recognition of first point
    %[idx2, C2] = kmedoids(matrix, 8, 'Distance','seuclidean'); % take centroids at outliers sometimes
    [idx3, C3] = kmedoids(matrix, 8, 'Distance','chebychev'); % no recognition of outliers, takes first
    %[idx4, C4] = kmedoids(matrix, 8, 'Distance','mahalanobis'); % weirdly good at finding outliers
    %[idx5, C5] = kmedoids(matrix, 8, 'Distance','correlation'); % marks outliers as well
    [idx6, C6] = kmedoids(matrix, 8, 'Distance','euclidean'); % no outliers, good centroids
    %[idx7, C7] = kmedoids(matrix, 8, 'Distance','cityblock'); % no outliers, good centroids does not wander much
    %[idx7, C7] = kmedoids(matrix, 8, 'Distance','cosine'); % detects some outliers, wanders much
    [idx8, C8] = kmedoids(matrix, 8, 'Distance','minkowski'); % no outliers, good centroids, very well centered
    %[idx7, C7] = kmedoids(matrix, 8, 'Distance','spearman'); % wanders,on outliers
    %[idx7, C7] = kmedoids(matrix, 8, 'Distance','hamming'); % wanders a lot, on outliers
    %[idx7, C7] = kmedoids(matrix, 8, 'Distance','jaccard'); % wanders a lot, on outliers
   
    % sorting 8 centroids in increasing x-coordinate for snapshot i
    [~,idx] = sort(C3(:,1));
    sortedcentroids3 = C3(idx,:);
    
    [~,idx] = sort(C6(:,1));
    sortedcentroids6 = C6(idx,:);
    
    [~,idx] = sort(C8(:,1));
    sortedcentroids8 = C8(idx,:);
    
    % summation of x and y -coords. of centroids over snapshots
    sum_of_centroids3 = sortedcentroids3 + sum_of_centroids3;
    sum_of_centroids6 = sortedcentroids6 + sum_of_centroids6;
    sum_of_centroids8 = sortedcentroids8 + sum_of_centroids8;
    
    % plots centroids for 3 distance methods for a snapshot with raw data
    %plot(matrix(:, 1), matrix(:, 2), 'k*', C3(:,1), C3(:,2), 'r+', C6(:,1), C6(:,2), 'gx', C8(:,1), C8(:,2), 'bd', 'MarkerSize', 10)
    %legend('raw', 'cheby' ,'euclidean', 'minkowski')
    %axis equal
    %set(gca,'XLim',[-750 -450],'YLim',[550 650])
    %pause(0.5)
end
% computation of average centroids of the 3 distance methods
avg_of_centroids3 = sum_of_centroids3/length(snapshotList);
avg_of_centroids6 = sum_of_centroids6/length(snapshotList);
avg_of_centroids8 = sum_of_centroids8/length(snapshotList);

% plot of average centroids with raw data over all snapshot
for i = 1:length(snapshotList)
    hold on
    
    % puts data in matrix for k-median clustering algorithm
    matrix = [snapshotList{i}.xmm,snapshotList{i}.ymm];
    
    % plotting of the 3 centroid distance methods averaged with raw data
    % over all snapshots
    plot(matrix(:,1), matrix(:,2), 'ko', avg_of_centroids3(:,1), avg_of_centroids3(:,2), 'r+', avg_of_centroids6(:,1), avg_of_centroids6(:,2), 'bx', avg_of_centroids8(:,1), avg_of_centroids8(:,2), 'g+', 'MarkerSize', 10)
    legend('raw', 'cheby' ,'euclidean', 'minkowski')
    %axis equal
end

end