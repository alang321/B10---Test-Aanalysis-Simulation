snapshotList = importSnapshotList("Case0.dat", "DATAPACKING", "ZONE");
%snapshotList1 = importSnapshotList("Case1.dat", "DATAPACKING", "ZONE");
%snapshotList2 = importSnapshotList("Case2.dat", "DATAPACKING", "ZONE");

%plotSnapshotList(snapshotList, 1/100);

%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)



snapshotListPerRow = groupSnapshotPerRow(snapshotList, 7);
snapshotListPerCol = groupSnapshotPerColumn(snapshotList, 8);

plotGroupedSnapshot(snapshotListPerRow, 1/100)
plotGroupedSnapshot(snapshotListPerCol, 1/100)
