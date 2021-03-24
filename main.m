
%plotSnapshotList(snapshotList, 1/100);

%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)


snapshotListReducedOutlier = removeOutliersDBScanRow(snapshotList, 4, 4);

[medoids snapshotListGroupedColKMed] = groupSnapshotKMedoids(snapshotList, 8);
snapshotListGroupedColDBScan = groupSnapshotDBScan(snapshotListReducedOutlier, 5, 3);
%[medoidList, snapshotListPerCol] = groupSnapshotKMedoids(snapshotList, 8);

plotComparedGroupings(snapshotListGroupedColKMed, snapshotListGroupedColDBScan)


%plotMedoids(medoidList, snapshotListPerCol)



%plotGroupedSnapshot(snapshotListPerRow, 1/100)
%plotGroupedSnapshot(snapshotListPerCol, 1/100)