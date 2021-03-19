function snapshotListPerColumn = groupSnapshotDBScan(snapshotList, epsilon, minpts)
snapshotListPerColumn = {};

for i = 1:length(snapshotList)
    snapshotPerColumn = {};
    
    idx = dbscan([snapshotList{i}.xmm snapshotList{i}.ymm], epsilon, minpts);
    
    for j = 1:max(idx)
        rowIndices = find(idx==j);
        
        snapshotPerColumn{end + 1} = snapshotList{i}(rowIndices,:);
    end
    
    snapshotListPerColumn{end + 1} = snapshotPerColumn;
end

end