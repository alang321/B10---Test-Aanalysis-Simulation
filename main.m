
%la vision porobe has 756 hz

%snapshotList = importSnapshotList("Case0.dat", "DATAPACKING", "ZONE");
%snapshotList1 = importSnapshotList("Case1.dat", "DATAPACKING", "ZONE");
%snapshotList2 = importSnapshotList("Case2.dat", "DATAPACKING", "ZONE");

load('snapshotList.mat')
load('snapshotList1.mat')
load('snapshotList2.mat')
%% 

plotSnapshotList(snapshotList, 1/756)
%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)


%% Put anything you want to run multiple times here without having to run the snapshot all over again
% expect long run-times for snapshotList 1 and 2
NACApolymodel(snapshotList)
%% 
snapshotList = importSnapshotList("Case0.dat", "DATAPACKING", "ZONE");
%snapshotList1 = importSnapshotList("Case1.dat", "DATAPACKING", "ZONE");
%snapshotList2 = importSnapshotList("Case2.dat", "DATAPACKING", "ZONE");

%plotSnapshotList(snapshotList, 1/100);

%plotCombinedSnapshotList(snapshotList1, snapshotList2, 1/756)



snapshotListPerRow = groupSnapshotPerRow(snapshotList, 7);
snapshotListPerCol = groupSnapshotPerColumn(snapshotList, 8);
snapshotListPerCol1 = groupSnapshotPerColumn(snapshotList1, 8);

plotGroupedSnapshot(snapshotListPerRow, 1/100)
plotGroupedSnapshot(snapshotListPerCol, 1/100)

%% column_data_gathering
TB_1 = snapshotListPerCol1{1,1}{1,1};
TB_2 = snapshotListPerCol1{1,1}{1,2};
TB_3 = snapshotListPerCol1{1,1}{1,3};
TB_4 = snapshotListPerCol1{1,1}{1,4};
TB_5 = snapshotListPerCol1{1,1}{1,5};
TB_6 = snapshotListPerCol1{1,1}{1,6};
TB_7 = snapshotListPerCol1{1,1}{1,7};
TB_8 = snapshotListPerCol1{1,1}{1,8};
for i = 2:3626
    % first column
    TB_1n = snapshotListPerCol1{1,i}{1,1};
    TB_1 = vertcat(TB_1, TB_1n);
    % second column
    TB_2n = snapshotListPerCol1{1,i}{1,2};
    TB_2 = vertcat(TB_2, TB_2n);
    % third column
    TB_3n = snapshotListPerCol1{1,i}{1,3};
    TB_3 = vertcat(TB_3, TB_3n);
    % fourth column
    TB_4n = snapshotListPerCol1{1,i}{1,4};
    TB_4 = vertcat(TB_4, TB_4n);
    % first column
    TB_5n = snapshotListPerCol1{1,i}{1,5};
    TB_5 = vertcat(TB_5, TB_5n);
    % second column
    TB_6n = snapshotListPerCol1{1,i}{1,6};
    TB_6 = vertcat(TB_6, TB_6n);
    % first column
    TB_7n = snapshotListPerCol1{1,i}{1,7};
    TB_7 = vertcat(TB_7, TB_7n);
    % 8th column
    TB_8n = snapshotListPerCol1{1,i}{1,8};
    TB_8 = vertcat(TB_8, TB_8n);
end
%% circle_fit
[x1, y1, R1] = circle_fit(table2array(TB_1(:,1)),table2array(TB_1(:,2)));
[x2, y2, R2] = circle_fit(table2array(TB_2(:,1)),table2array(TB_2(:,2)));
[x3, y3, R3] = circle_fit(table2array(TB_3(:,1)),table2array(TB_3(:,2)));
[x4, y4, R4] = circle_fit(table2array(TB_4(:,1)),table2array(TB_4(:,2)));
[x5, y5, R5] = circle_fit(table2array(TB_5(:,1)),table2array(TB_5(:,2)));
[x6, y6, R6] = circle_fit(table2array(TB_6(:,1)),table2array(TB_6(:,2)));
[x7, y7, R7] = circle_fit(table2array(TB_7(:,1)),table2array(TB_7(:,2)));
[x8, y8, R8] = circle_fit(table2array(TB_8(:,1)),table2array(TB_8(:,2)));

%% plot_column_data

