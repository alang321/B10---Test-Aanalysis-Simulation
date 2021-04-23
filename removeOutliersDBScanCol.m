function snapshotList = removeOutliersDBScanCol(snapshotList, epsilon, minpts)

for i = 1:length(snapshotList)
    
    idx = dbscan([snapshotList{i}.xmm, snapshotList{i}.ymm], epsilon, minpts);
    
    rowIndices = find(idx==-1);

    snapshotList{i}(rowIndices,:) = [];
    
end

end