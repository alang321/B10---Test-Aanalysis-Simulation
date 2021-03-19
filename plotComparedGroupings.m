function plotComparedGroupings(grouping1, grouping2)

for i = 1:length(grouping1)
    
    scatter(grouping1{i}{1}.xmm, grouping1{i}{1}.ymm, 15, [120,120,120]/256, 'filled')
    hold on
    for j = 2:length(grouping1{i})
        scatter(grouping1{i}{j}.xmm, grouping1{i}{j}.ymm, 15, [120,120,120]/256, 'filled')
    end
    
    for j = 1:length(grouping2{i})
        scatter(grouping2{i}{j}.xmm, grouping2{i}{j}.ymm, 15, [256,0,0]/256)
    end
    
    hold off
    
    
    axis equal
    set(gca,'XLim',[-800 -400],'YLim',[500 700])
    
    pause(0.5)
end

end