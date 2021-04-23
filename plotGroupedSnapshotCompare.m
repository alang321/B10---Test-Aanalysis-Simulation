function plotGroupedSnapshotCompare(grouping, snapshot, centroids)

scatter(snapshot.xmm, snapshot.ymm, 25, [120,120,120]/256, 'filled','DisplayName','Captured Data')
hold on
for j = 1:length(grouping)
    scatter(grouping{j}.xmm, grouping{j}.ymm, 25, 'LineWidth',2 ,'DisplayName','Cluster')
end

scatter(centroids(1,:), centroids(2,:), 15, [0,256,0]/256, 'filled', 'LineWidth',2, 'DisplayName','centroid')

legend
hold off


set(gca,'XLim',[-740 -450],'YLim',[550 650])

title('Snapshot:', int2str(i))
    

end