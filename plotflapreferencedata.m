function plotflapreferencedata(X,Y)

plot(X, Y, 'rx')
hold on

xnew = (0:0.005:1)';
ynew = interp1(X, Y, xnew, 'spline');
plot(xnew, ynew, 'b-')

title('Reference Data Plot; Normalized Time Period Variation of Flap Deflection Angle')
xlabel('Normalized Time Period [-]')
ylabel('Flap Deflection Angle [deg]')

legend("Reference Data Points", "Linear Interpolation")
end