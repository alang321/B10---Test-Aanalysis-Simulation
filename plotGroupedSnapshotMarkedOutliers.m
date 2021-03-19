function plotGroupedSnapshotMarkedOutliers(snapshot)

hold on
for i = 1:length(snapshot)
    colormap jet
    scatter(snapshot{i}.xmm, snapshot{i}.ymm, [], snapshot{i}.isOutlier)
    scatter(median([snapshot{i}.xmm, snapshot{i}.ymm]), 'greeno')
end
hold off

end