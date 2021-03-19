function snapshotClusteredList = markOutliersFromClusters2D(snapshotClusteredList)
addpath('./Outliers Multivariate Datasets');

%for i = 1:length(snapshotClusteredList)
for i = 1:2
    for j = 1:length(snapshotClusteredList{i})
        [mu,S,RD,chi_crt] = DetectMultVarOutliers(snapshotClusteredList{i}{j}{:,1:2});

        outliers = zeros(length(RD), 1);
        for k = 1:length(RD)
            if RD(k) >= chi_crt(1)
               outliers(k) = 1;
            end
        end
        name = 'isOutlier';
        snapshotClusteredList{i}{j}.(name) = outliers;
    end
end

end