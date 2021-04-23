function average = DBScanCase0Average(case0)

case0Combined = {};
a = removeOutliersDBScanRow(case0, 5, 3);
a = removeOutliersDBScanCol(a, 5, 3);
for i = 1:length(a)
    case0Combined = [case0Combined; a{i}];
end
%scatter3(case0Combined.xmm, case0Combined.ymm, case0Combined.zmm)

[idx, mediods] = kmeans([case0Combined.xmm case0Combined.ymm], 8);
    
average = transpose(sort(mediods, 1, 'ascend')); 
end