function piecewisepoly(list)
%PIECEWISEPOLY Summary of this function goes here
%   This function should create a piecewise polynomial by using the x-y
%   coordinates of the points
x=[];
y=[];
a=[];
b=[];
c=[];
d=[];
M=[0];
f=[];
h=35; %mm ideal spacing
row=[1,7,14,21,28,35,42,49];
for i=row
    x=[x,list{1}.xmm(i)];
    y=[y,list{1}.ymm(i)];
end
A=[4 1 0 0 0 0; 1 4 1 0 0 0; 0 1 4 1 0 0; 0 0 1 4 1 0 ; 0 0 0 1 4 1; 0 0 0 0 1 4];
for i=2:7
    f=[f,(y(i+1)-2*y(i)+y(i-1))/h];
end
B=linsolve(A,(f.'));
M=[M,B.',0];
for i=1:7
     a=[a,(M(i+1)-M(i))/(6*h)];
     b=[b, M(i)/2];
     c=[c,(y(i+1)-y(i))/h-h*M(i)/3-h*M(i+1)];
     d=[d,y(i)];
end
    function [spline]=s(i,x_0,x,a,b,c,d)
        spline = []
        for j=x_0
            spline=[spline, a(i)*(j-x(i))^3+b(i)*(j-x(i))^2+c(i)*(j-x(i))+d(i)];
        end
    end
a,b,c,d,M
for i=1:7
    x_0 = x(i):0.1:x(i+1);
    hold on
    plot (x_0,s(i,x_0,x,a,b,c,d))
    
    scatter (x,y)
    hold off
end
end

