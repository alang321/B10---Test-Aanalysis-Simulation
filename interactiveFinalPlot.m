function interactiveFinalPlot(xBody, anglesBody, xFlap, anglesFlap, relativeAngle, snapshots, medians, clusters, errorsx, showErrors)
figure
aH = axes;

setappdata(aH,'snapshots',snapshots);
setappdata(aH,'medians',medians);
setappdata(aH,'clusters',clusters);

lH(1) = plot(transpose(cell2mat(xBody)), transpose(cell2mat(anglesBody)), 'Parent', aH,'DisplayName','Body');
hold on
lH(2) = plot(transpose(cell2mat(xFlap)), transpose(cell2mat(anglesFlap)), 'Parent', aH,'DisplayName','Flap');
lH(3) = plot(transpose(cell2mat(xBody)), transpose(cell2mat(relativeAngle)), 'Parent', aH,'DisplayName','Relative');
if length(errorsx) ~= 0 && showErrors
    lH(4) = plot(transpose(cell2mat(errorsx)), zeros(1, length(errorsx)), 'Parent', aH,'DisplayName','Errors');
    lH(5) = scatter(transpose(cell2mat(errorsx)), zeros(1, length(errorsx)), 3, 'Parent', aH,'DisplayName','Errors');
end
%lH(6) = scatter(transpose(cell2mat(xBody)), transpose(cell2mat(relativeAngle)), 3, 'Parent', aH,'DisplayName','Relative');
%lH(7) = scatter(transpose(cell2mat(xFlap)), transpose(cell2mat(anglesFlap)), 3, 'Parent', aH,'DisplayName','Flap');
%lH(8) = scatter(transpose(cell2mat(xBody)), transpose(cell2mat(anglesBody)), 3, 'Parent', aH,'DisplayName','Body');
set(lH,'hittest','off'); % so you can click on the Markers
hold on; 
set(aH,'ButtonDownFcn',@getCoord); % Defining what happens when clicking

legend
title('AOA of rotor blade')
xlabel('t [sec]') 
ylabel('aoa [deg]') 

end