function getCoord(aH,evnt)
drawnow
f = ancestor(aH,'figure');
click_type = get(f,'SelectionType');
if strcmp(click_type,'normal')
    ptH = getappdata(aH,'CurrentPoint');
    delete(ptH)
    %Finding the closest point and highlighting it
    lH = findobj(aH,'Type','line');
    minDist = realmax;
    finalIdx = NaN;
    finalH = NaN;
    pt = get(aH,'CurrentPoint'); %Getting click position
    for ii = lH'
        xp=get(ii,'Xdata'); %Getting coordinates of line object
        yp=get(ii,'Ydata');
        dx=daspect(aH);      %Aspect ratio is needed to compensate for uneven axis when calculating the distance
        [newDist idx] = min( ((pt(1,1)-xp).*dx(2)).^2 + ((pt(1,2)-yp).*dx(1)).^2 );
        if (newDist < minDist)
            finalH = ii;
            finalIdx = idx;
            minDist = newDist;
        end
    end
    xp=get(finalH,'Xdata'); %Getting coordinates of line object
    yp=get(finalH,'Ydata');
    ptH = plot(aH,xp(finalIdx),yp(finalIdx),'k*','MarkerSize',20);
    setappdata(aH,'CurrentPoint',ptH);
    setappdata(aH,'CurrentX',xp(finalIdx));
elseif strcmp(click_type,'alt')
    %do your stuff once your point is selected   
    disp('Done clicking!');
    disp(getappdata(aH,'CurrentX'));
    
    i = round(getappdata(aH,'CurrentX') * 100)
    
    clusters = getappdata(aH,'clusters');
    snapshots = getappdata(aH,'snapshots');
    medians = getappdata(aH,'medians');
    figure
    plotGroupedSnapshotCompare(clusters{i}, snapshots{i}, medians{i})
end