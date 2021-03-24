
%plotSnapshotList(snapshotList, 1/100);

%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)


snapshotListReducedOutlier = removeOutliersDBScanRow(snapshotList, 4, 4);

[medoids snapshotListGroupedColKMed] = groupSnapshotKMedoids(snapshotList, 8);
snapshotListGroupedColDBScan = groupSnapshotDBScan(snapshotListReducedOutlier, 5, 3);
%[medoidList, snapshotListPerCol] = groupSnapshotKMedoids(snapshotList, 8);

plotComparedGroupings(snapshotListGroupedColKMed, snapshotListGroupedColDBScan)


%plotMedoids(medoidList, snapshotListPerCol)


<<<<<<< HEAD

%plotGroupedSnapshot(snapshotListPerRow, 1/100)
%plotGroupedSnapshot(snapshotListPerCol, 1/100)
=======
snapshotListPerRow = groupSnapshotPerRow(snapshotList, 7);
snapshotListPerCol = groupSnapshotPerColumn(snapshotList, 8);
%snapshotListPerCol1 = groupSnapshotPerColumn(snapshotList1, 8);

plotGroupedSnapshot(snapshotListPerRow, 1/100)
plotGroupedSnapshot(snapshotListPerCol, 1/100)

%% column_data_gathering
%TB_1 = snapshotListPerCol1{1,1}{1,1};

%for i = 2:3626
    % first column
    %TB_1n = snapshotListPerCol1{1,i}{1,1};
    %TB_1 = vertcat(TB_1, TB_1n);
%end
%% circle_fit
%[x1, y1, R1] = circle_fit(table2array(TB_1(:,1)),table2array(TB_1(:,2)));

%% plot_column_data

>>>>>>> 4d7893beae60eb3db4e79628bd530f4cd079b9be
