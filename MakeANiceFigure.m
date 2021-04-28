function MakeANiceFigure(x, xlabelname, y, ylabelname, titlename, xbegin, xend, ybegin, yend, includelegend=False, xlegendname, ylegendname)
plot(x , y, 'b--')
title(titlename)
if includelegend=True:
    legend(xlegendname, ylegendname)
xlabel(xlabelname); ylabel(ylabelname)
axis equal
set(gca,'XLim',[xbegin xend],'YLim',[ybegin yend])
end