function plotCombinedSnapshotList(snapshotList1, snapshotList2, delay)
set(gcf, 'Position', get(0, 'Screensize'));
for i = 1:length(snapshotList1)
    subplot(2,2,1)
    scatter3(snapshotList1{i}.xmm, snapshotList1{i}.ymm, snapshotList1{i}.zmm)
    hold on
    scatter3(snapshotList2{i}.xmm, snapshotList2{i}.ymm, snapshotList2{i}.zmm)
    hold off
    title('Isometric', int2str(i))
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    
    subplot(2,2,2)
    scatter3(snapshotList1{i}.xmm, snapshotList1{i}.ymm, snapshotList1{i}.zmm)
    hold on
    scatter3(snapshotList2{i}.xmm, snapshotList2{i}.ymm, snapshotList2{i}.zmm)
    hold off
    view(0,90)
    title('top')
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    title('Top', int2str(i))
    
    subplot(2,2,3)
    scatter3(snapshotList1{i}.xmm, snapshotList1{i}.ymm, snapshotList1{i}.zmm)
    hold on
    scatter3(snapshotList2{i}.xmm, snapshotList2{i}.ymm, snapshotList2{i}.zmm)
    hold off
    view(90,0)
    title('top')
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700],'ZLim',[550 950])
    title('Top', int2str(i))
    
    pause(delay)
end

end