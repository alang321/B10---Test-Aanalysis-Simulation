function sortedPointsWithFewOutliersCase0(input1,whichSnapshot)
%input1 is a table (snaphotListGroupedColDBScan in this case),
%this function should work with case0, 1, 2 as long as the data is without
%ouliers and is in a table.
p=whichSnapshot;
x=0;
y=0;
Xavg=0;
Yavg=0;
%hold on
%axis equal
for i = 1:length(input1)
    
    for j = 1:length(input1{i})
    x=input1{i}{j}.xmm;
    Xavg(i,j)=sum(x)/length(x);
    y=input1{i}{j}.ymm;
    Yavg(i,j)=sum(y)/length(y);
    
    %scatter(Xavg(i,j), Yavg(i,j), 15, [256,0,0]/256)
    %title('Snapshot:', i)
    end
    
end
%hold off


axis equal
hold on
for j=1:length(input1{p})
scatter(Xavg(p,j), Yavg(p,j), 15, [256,0,0]/256)
title('Snapshot:', p)
end
hold off

%Xavg(100,2) %first number is snapshot, second is tracker ID (one to eight)
%Yavg(1,1)

end