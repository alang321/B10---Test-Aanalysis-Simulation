function snapshotListPerColumn = groupSnapshotPerColumn(snapshotList, numClusters)
snapshotListPerColumn = {};

for i = 1:length(snapshotList)
    snapshotPerColumn = {};
    
    idx = kmedoids([snapshotList{i}.xmm snapshotList{i}.ymm], numClusters);
    
    for j = 1:numClusters
        rowIndices = find(idx==j);
        snapshotPerColumn{end + 1} = snapshotList{i}(rowIndices,:);
    end
    
    snapshotListPerColumn{end + 1} = snapshotPerColumn;
end

end