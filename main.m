snapshot = snapshotList;

x = [147.60473706377394 182.53356646347572 217.37859951713284 252.13323652288875 286.79848832784944 316.43952717794 350.9195695241304 385.3032800407517];
y = [-35.18937883549954 -33.09843552219046 -29.859305492922243 -25.743226393062304 -20.922755972022706 -16.295789807523565 -10.288879892895812 -3.757070215678503];
ref = [x; y];

x1 = [-719.2141 -683.2147 -648.3127 -614.3401 -579.0444 -546.6513 -512.1990 -478.0280];
y1 = [576.6304 578.5438 582.0158 586.4820 591.2920 596.3880 602.2807 608.4452];
case0avg = [x1; y1];

case0avg2 = DBScanCase0Average(snapshotList);

snapshotListReducedOutlier = removeOutliersDBScanRow(snapshot, 4, 4);

snapshotListGroupedColDBScan = groupSnapshotDBScan(snapshotListReducedOutlier, 4, 3);
%snapshotListGroupedColDBScan = groupSnapshotDBScanAveraged(snapshotListReducedOutlier, 1, 5, 6);

%plotComparedGroupings(snapshotListGroupedColKMed, snapshotListGroupedColDBScan)


%get an approximation where the hingepoint is for case 0 average (so at 0 aoa)
a = absor(ref, case0avg2);
hinge = a.R * [(400 * 0.75); 0] + a.t

medianPerSnapshot = getSortedMediansFromColumnClusters(snapshotListGroupedColDBScan);

%[anglesBody, xBody, errorsx] = getRotationFromReference2dFixedFlap(case0avg, medianPerSnapshot);
[anglesBody, xBody, anglesFlap, xFlap, errorsx] = getRotationFromReference2dMovingFlap(case0avg2, medianPerSnapshot);

interactiveFinalPlot(xBody, anglesBody, xFlap, anglesFlap, snapshot, medianPerSnapshot, snapshotListGroupedColDBScan, errorsx);



