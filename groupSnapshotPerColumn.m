function [medoidList, snapshotListPerColumn] = groupSnapshotPerColumn(snapshotList, numClusters)
snapshotListPerColumn = {};
medoidList = {};

for i = 1:length(snapshotList)
    snapshotPerColumn = {};
    
    [idx, mediods] = kmedoids([snapshotList{i}.xmm snapshotList{i}.ymm], numClusters);
    
    medoidList{end + 1} = sort(mediods, 1);
    
    for j = 1:numClusters
        rowIndices = find(idx==j);
        
        snapshotPerColumn{end + 1} = snapshotList{i}(rowIndices,:);
    end
    
    snapshotListPerColumn{end + 1} = snapshotPerColumn;
end

end