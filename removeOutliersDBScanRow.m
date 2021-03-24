function snapshotList = removeOutliersDBScanRow(snapshotList, epsilon, minpts)

for i = 1:length(snapshotList)
    
    idx = dbscan([snapshotList{i}.zmm], epsilon, minpts);
    
    rowIndices = find(idx==-1);

    snapshotList{i}(rowIndices,:) = [];
    
end

end