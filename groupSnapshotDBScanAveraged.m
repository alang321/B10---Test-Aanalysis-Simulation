function snapshotListPerColumn = groupSnapshotDBScanAveraged(snapshotList, range, epsilon, minpts)
snapshotListPerColumn = {};

for i = 1:length(snapshotList)
    snapshotPerColumn = {};
    
    a = {};
    for j = max(1, i-range):min(length(snapshotList), i+range)
        a = [a; snapshotList{j}];
    end
    
    idx = dbscan([a.xmm a.ymm], epsilon, minpts);
    
    for j = 1:max(idx)
        rowIndices = find(idx==j);
        
        snapshotPerColumn{end + 1} = a(rowIndices,:);
    end
    
    %plotGroupedSnapshotCompare(snapshotPerColumn, a)
    
    snapshotListPerColumn{end + 1} = snapshotPerColumn;
end

end