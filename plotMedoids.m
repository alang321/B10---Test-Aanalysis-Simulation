function plotMedoids(medoidList, snapshotList)

for i = 1:length(medoidList)
    scatter(snapshotList{i}{1}.xmm, snapshotList{i}{1}.ymm, 15, [169,169,169]/256)
    
    hold on
    for j = 2:length(snapshotList{i})
        scatter(snapshotList{i}{j}.xmm, snapshotList{i}{j}.ymm, 15, [120,120,120]/256)
    end
    
    scatter(medoidList{i}(:,1), medoidList{i}(:,2), 25, [0 0 256]/256, 'filled')
    
    hold off
    
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700])
    
    pause(0.5)
end

end
