function [xo, yo, R] = circle_fit(x,y)


% x = snapshotListPerCol1{1,1}{1,2}(:,1);
% y = snapshotListPerCol1{1,1}{1,2}(:,2);

A = [-2*x -2*y ones(length(x),1)];
x = A\-(x.^2+y.^2);
xo=x(1);
yo=x(2);
R = sqrt(  xo.^2 + yo.^2  - x(3));
