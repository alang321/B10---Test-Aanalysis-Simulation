function medoidList = getSortedMedoidFromColumnClusters(snapshotListCol)

medoidList = {};


for i = 1:length(snapshotListCol)
    medoidArray = zeros(length(snapshotListCol{i}), 2);
    for j = 1:length(snapshotListCol{i})
        [idx, medoid] = kmedoids([snapshotListCol{i}{j}.xmm snapshotListCol{i}{j}.ymm], 1);
        medoidArray(j, 1) = medoid(1, 1);
        medoidArray(j, 2) = medoid(1, 2);
    end
        
    medoidList{end  + 1} = transpose(sortrows(medoidArray,1, 'ascend'));
end

end