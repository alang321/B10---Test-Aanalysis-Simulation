
%la vision porobe has 756 hz

snapshotList = importSnapshotList("Case0.dat", "DATAPACKING", "ZONE");
%snapshotList1 = importSnapshotList("Case1.dat", "DATAPACKING", "ZONE");
%snapshotList2 = importSnapshotList("Case2.dat", "DATAPACKING", "ZONE");

plotSnapshotList(snapshotList, 1/756)
%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)