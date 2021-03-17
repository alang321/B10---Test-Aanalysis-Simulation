function  linear(list)
%LINEAR Summary of this function goes here
%   Detailed explanation goes here
row=[1,7,14,21,28,35,42,49];
x=[];
y=[];
for i=row
    x=[x,list{1}.xmm(i)];
    y=[y,list{1}.ymm(i)];
end
a = (y(7)-y(5))/(x(7)-x(5));
b = y(5)-a*x(5);
a,b
   function [p_x]=s(x_0,a,b)
       p_x = [];
       for j=x_0
            p_x=[p_x,a*j+b ];
       end
   end


x_0 = x(5):0.1:x(7);

hold on
plot (x_0,s(x_0,a,b))
ylim([400,700])
scatter (x,y)
hold off

end

