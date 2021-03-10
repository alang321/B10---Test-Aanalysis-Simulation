function NACApolymodel(snapshotList)

chord = 0.4*1000; %mm

T = 0.18; % percentage of chord

% true polynomial constants
a_0 = 0.2969;
a_1 = -0.126;
a_2 = -0.3516;
a_3 = 0.2843;
a_4 = -0.1036;




% polynomial expression; x is in range 0 to 1 (percentage of chord), y is
% measured from the chordline 0 to T/2.
y = @(x) T/0.2 * (a_0 * x.^0.5 + a_1 * x + a_2 * x.^2 + a_3 * x.^3 + a_4 * x.^4);

% plot true polynomial
%if arg is true:
%    x = linspace(0, 1, 1000);
%    plot(x, y(x))
%end

%DO NOT TOUCH ANYTHING HERE ASK ERIK
x_maxlst = zeros(1, length(snapshotList));
y_obs_xmaxlst = zeros(1, length(snapshotList));
CLlst = zeros(1, length(snapshotList));

for k = 1:length(snapshotList)
    k;
    % Initialise with maximum xmm:
    x_max = max(snapshotList{k}.xmm); % mm
    x_maxlst(k) = x_max;
    
    %disp("Trailing Edge Xpos. from PIV base in mm")
    TE = x_max + 15; % mm

    %disp("Leading Edge Xpos. from PIV base in mm")
    LE = TE - 400; % mm

    % perc. chord of x_max
    PER_x_max = (x_max + abs(LE))/chord; % perc. chord

    % true y of x_max in mm
    y_tru_xmax = y(PER_x_max) * chord; % mm

    % observed y at x_max in mm
    index = find(snapshotList{k}.xmm == x_max);
    y_obs_xmax = snapshotList{k}.ymm(index); % mm
    y_obs_xmaxlst(k) = y_obs_xmax;
    
    %disp("Chordline Ypos. from PIV base in mm")
    CL = y_obs_xmax + y_tru_xmax; % mm
    CLlst(k) = CL;
end

k = 1:length(snapshotList);
% plot of variation of chordline Ypos. over snapshotList
subplot(1,3,1)
plot(k, CLlst)
title("Snapshot vs. Chordline Ypos.")
xlabel("Snapshot [-]")
ylabel("Chordline Ypos. [mm]")
axis equal

subplot(1,3,2)
plot(k, x_maxlst)
title("Snapshot vs. Maximum X")
xlabel("Snapshot [-]")
ylabel("Maximum X [mm]")
axis equal

subplot(1,3,3)
plot(x_maxlst, y_obs_xmaxlst)
title("X, Y pos. data for X max over all Snapshots")
xlabel("Maximum X [mm]")
ylabel("Y at Maximum X. [mm]")
axis equal

% use observed x to compute a true y to compare with observed y,  then form least-squares to determine error compared to
% true form.






