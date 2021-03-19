function plotGroupedSnapshot(perColumnSnapshotList, delay)
    
for i = 1:length(perColumnSnapshotList)
    for j = 1:length(perColumnSnapshotList{i})
        subplot(2,2,1)
        scatter3(perColumnSnapshotList{i}{j}.xmm, perColumnSnapshotList{i}{j}.ymm, perColumnSnapshotList{i}{j}.zmm)
        hold on
        title('Isometric', int2str(i))
        axis equal
        set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    end
    hold off
    
    
    for j = 1:length(perColumnSnapshotList{i})
        subplot(2,2,2)
        scatter3(perColumnSnapshotList{i}{j}.xmm, perColumnSnapshotList{i}{j}.ymm, perColumnSnapshotList{i}{j}.zmm)
        hold on
        view(0,90)
        title('top')
        axis equal
        set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
        title('Top', int2str(i))
    end
    hold off
    
    pause(delay)
end

end