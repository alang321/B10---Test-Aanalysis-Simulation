
snapshotListReducedOutlier = removeOutliersDBScanRow(snapshotList, 4, 4);

[medoids, snapshotListGroupedColKMed] = groupSnapshotKMedoids(snapshotList, 8);
snapshotListGroupedColDBScan = groupSnapshotDBScan(snapshotListReducedOutlier, 5, 3);

%plotComparedGroupings(snapshotListGroupedColKMed, snapshotListGroupedColDBScan)

x = [147.60473706377394 182.53356646347572 217.37859951713284 252.13323652288875 286.79848832784944 316.43952717794 350.9195695241304 385.3032800407517];
y = [-35.18937883549954 -33.09843552219046 -29.859305492922243 -25.743226393062304 -20.922755972022706 -16.295789807523565 -10.288879892895812 -3.757070215678503];
ref = [x; y];

x1 = [-719.2141 -683.2147 -648.3127 -614.3401 -579.0444 -546.6513 -512.1990 -478.0280];
y1 = [576.6304 578.5438 582.0158 586.4820 591.2920 596.3880 602.2807 608.4452];
case0avg = [x1; y1];

%get an approximation where the hingepoint is for case 0 average (so at 0 aoa)
a = absor(ref, case0avg);
hinge = a.R * [(400 * 0.75); 0] + a.t

medianPerSnapshot = getSortedMediansFromColumnClusters(snapshotListGroupedColKMed);

%[anglesBody, xPosBody, errorsx] = getRotationFromReference2dFixedFlap(case0avg, medianPerSnapshot);
[anglesBody, xPosBody, anglesFlap, xPosFlap, errorsx] = getRotationFromReference2dMovingFlap(case0avg, medianPerSnapshot);

plot(transpose(cell2mat(xPosBody)), transpose(cell2mat(anglesBody)))
hold on
plot(transpose(cell2mat(xPosFlap)), transpose(cell2mat(anglesFlap)))
hold off

title('AOA of rotor blade')
xlabel('t [sec]') 
ylabel('aoa [deg]') 


