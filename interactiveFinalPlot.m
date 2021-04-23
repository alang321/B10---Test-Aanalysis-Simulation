function interactiveFinalPlot(xBody, anglesBody, xFlap, anglesFlap, snapshots, medians, clusters, errorsx)
figure
aH = axes;

setappdata(aH,'snapshots',snapshots);
setappdata(aH,'medians',medians);
setappdata(aH,'clusters',clusters);

lH(1) = plot(transpose(cell2mat(xBody)), transpose(cell2mat(anglesBody)), 'Parent', aH);
hold on
lH(2) = scatter(transpose(cell2mat(xBody)), transpose(cell2mat(anglesBody)), 10, 'Parent', aH);
lH(3) = plot(transpose(cell2mat(xFlap)), transpose(cell2mat(anglesFlap)), 'Parent', aH);
lH(4) = scatter(transpose(cell2mat(xFlap)), transpose(cell2mat(anglesFlap)), 10, 'Parent', aH);
lH(5) = plot(transpose(cell2mat(errorsx)), zeros(1, length(errorsx)), 'Parent', aH);
lH(5) = scatter(transpose(cell2mat(errorsx)), zeros(1, length(errorsx)), 10, 'Parent', aH);
set(lH,'hittest','off'); % so you can click on the Markers
hold on; 
set(aH,'ButtonDownFcn',@getCoord); % Defining what happens when clicking

title('AOA of rotor blade')
xlabel('t [sec]') 
ylabel('aoa [deg]') 

end