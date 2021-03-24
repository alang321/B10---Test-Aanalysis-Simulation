function plotComparedSnapshots(snapshot1, snapshot2)

for i = 1:length(snapshot1)
    
    scatter(snapshot1{i}{1}.xmm, snapshot1{i}{1}.ymm, 15, [120,120,120]/256, 'filled')
    hold on
    scatter(snapshot1{i}.xmm, snapshot1{i}.ymm, 15, [120,120,120]/256, 'filled')
    
    scatter(snapshot2{i}.xmm, snapshot2{i}.ymm, 15, [256,0,0]/256)
    
    hold off
    
    
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700])
    
    pause(0.5)
end

end