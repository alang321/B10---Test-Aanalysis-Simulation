function plotSnapshotList(snapshotList, delay)
    
for i = 1:length(snapshotList)
    subplot(2,2,1)
    scatter3(snapshotList{i}.xmm, snapshotList{i}.ymm, snapshotList{i}.zmm)
    title('Isometric', int2str(i))
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    
    subplot(2,2,2)
    scatter3(snapshotList{i}.xmm, snapshotList{i}.ymm, snapshotList{i}.zmm)
    view(0,90)
    title('top')
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    title('Top', int2str(i))
    
    subplot(2,2,3)
    scatter3(snapshotList{i}.xmm, snapshotList{i}.ymm, snapshotList{i}.zmm)
    view(90,0)
    title('top')
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    title('Front', int2str(i))
    
    pause(delay)
end

end