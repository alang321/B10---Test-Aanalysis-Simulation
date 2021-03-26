function [main,flap]=linear(list,n)
%LINEAR Summary of this function goes here
  %List stands for the case. k is the leftmost point(used), m i the rightmost
  %point(used), n is the snapshot number in the list
row=[1,7,14,21,28,35,42,49];
x=[];
y=[];
if height(list{n})<8
    main=0;
    flap=0;
else 
    for i=1:height(list{n})
        x=[x,list{n}(i,1)];
        y=[y,list{n}(i,2)];
    end
%     x=[-719.2141,-683.2147,-648.3127,-614.3401,-579.0444,-546.6513,-512.1990,-478.0280];
%     y=[576.6304,578.5438,582.0185,586.4820,591.2920,596.3880,602.2807,608.4452];
    a1 = (y(8)-y(6))/(x(8)-x(6));
    a2 = (y(5)-y(2))/(x(5)-x(2));
    main = atan(a2-0.1224)*180/3.1415;
    flap = atan(a1-0.1757)*180/3.1415;
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
