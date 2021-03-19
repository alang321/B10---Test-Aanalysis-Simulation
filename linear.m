function [aoa]=linear(list,k,m,n)
%LINEAR Summary of this function goes here
%   List stands for the case. k is the leftmost point(used), m i the rightmost
%   point(used), n is the snapshot number in the list
row=[1,7,14,21,28,35,42,49];
x=[];
y=[];
if height(list{n})<49
    aoa=0;
else 
    for i=row
        x=[x,list{n}.xmm(i)];
        y=[y,list{n}.ymm(i)];
    end
    x=sort(x);
    y=sort(y);
    a = (y(m)-y(k))/(x(m)-x(k));
    % b = y(m)-a*x(m);
    aoa=atan(a-0.1794);
%    function [p_x]=s(x_0,a,b)
%        p_x = [];
%        for j=x_0
%             p_x=[p_x,a*j+b ];
%        end
%    end

% x_0 = x(k):0.1:x(m);
% hold on
% plot (x_0,s(x_0,a,b))
% ylim([400,700])
% scatter (x,y)
% hold off

end

