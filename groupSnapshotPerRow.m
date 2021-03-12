function snapshotListPerRow = groupSnapshotPerRow(snapshotList, numClusters)
snapshotListPerRow = {};

for i = 1:length(snapshotList)
    snapshotPerRow = {};
    
    idx = kmedoids([snapshotList{i}.ymm snapshotList{i}.zmm], numClusters);
    
    for j = 1:numClusters
        rowIndices = find(idx==j);
        snapshotPerRow{end + 1} = snapshotList{i}(rowIndices,:);
    end
    
    snapshotListPerRow{end + 1} = snapshotPerRow;
end

end