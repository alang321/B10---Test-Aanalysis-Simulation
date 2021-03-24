
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


%% cell manipulation TB_12345678
new_snap = {};
for i = 1:3626
    % loop to get the sequence of 8 column
    for j = 1:8
        TB_1 = snapshotListPerCol1{1,i}{1,j};
        list_array = table2array(TB_1);
        list_value(j) = list_array(1,1);
    end
    [out,idx] = sort(list_value);
    % create new cell based on sequence of x value
    for jj = 1:8
        new_snap{1,i}{1,jj} = snapshotListPerCol1{1,i}{1,idx(jj)};
    end
    
end

% from new snapshotlist
TB_1 = new_snap{1,1}{1,1};
TB_2 = new_snap{1,1}{1,2};
TB_3 = new_snap{1,1}{1,3};
TB_4 = new_snap{1,1}{1,4};
TB_5 = new_snap{1,1}{1,5};
TB_6 = new_snap{1,1}{1,6};
TB_7 = new_snap{1,1}{1,7};
TB_8 = new_snap{1,1}{1,8};

for i = 2:3626
    % second column
    TB_1n = new_snap{1,i}{1,1};
    TB_1 = vertcat(TB_1, TB_1n);
    % second column
    TB_2n = new_snap{1,i}{1,2};
    TB_2 = vertcat(TB_2, TB_2n);
    % second column
    TB_4n = new_snap{1,i}{1,4};
    TB_4 = vertcat(TB_4, TB_4n);
    % second column
    TB_5n = new_snap{1,i}{1,5};
    TB_5 = vertcat(TB_5, TB_5n);
    % second column
    TB_6n = new_snap{1,i}{1,6};
    TB_6 = vertcat(TB_6, TB_6n);
    % second column
    TB_7n = new_snap{1,i}{1,7};
    TB_7 = vertcat(TB_7, TB_7n);
    % second column
    TB_8n = new_snap{1,i}{1,8};
    TB_8 = vertcat(TB_8, TB_8n);
end

%% circle fitting

>>>>>>> 4d7893beae60eb3db4e79628bd530f4cd079b9be
