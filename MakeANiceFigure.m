function MakeANiceFigure(x, xlabelname, y, ylabelname, titlename, xbegin, xend, ybegin, yend, includelegend, xlegendname, ylegendname)
% Figure creator to provide consistent style.
% x, y are your NUMERICAL data inputs
% xlabelname, ylabelname are the TEXT inputs for the axis labels
% titlename is the TEXT input for the figure title
% xbegin, xend, ybegin, yend are the NUMERICAL inputs for the begin and end
% of each axis.
% includelegend is a TRUE/FALSE indicator to incidate whether you would
% like to include a legend or not.
% if you choose to include a legend (i.e. TRUE), then,
% xlegendname, ylegendname are TEXT input for the legend labels.

plot(x , y, 'b--')
title(titlename)
if includelegend == true
    legend(xlegendname, ylegendname)
end
xlabel(xlabelname); ylabel(ylabelname)
axis equal
set(gca,'XLim',[xbegin xend],'YLim',[ybegin yend])
end