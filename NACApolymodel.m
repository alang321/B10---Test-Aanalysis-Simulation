function NACApolymodel(snapshotList)

chord = 0.4*1000; %mm

T = 0.18; % percentage of chord

% intialising polynomial constants
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

% initialising vectors to append in for loop
x_maxlst = zeros(1, length(snapshotList));
y_obs_xmaxlst = zeros(1, length(snapshotList));
CLlst = zeros(1, length(snapshotList));


% for loop over all snapshots, find maximum x (closest recognized marker to
% the PIV origin) to compute location of TE and therefore also the y
% position of the chordline wrt PIV origin.
% ASSUMES THAT MAX X IS THE LAST COLUMN OF MARKERS 15 mm from TE!!!

for k = 1:length(snapshotList)
    % iteration num.
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

    % true y (measured from chordline) of x_max in mm
    y_tru_xmax = y(PER_x_max) * chord; % mm

    % observed y (measured from PIV origin) at x_max in mm
    index = find(snapshotList{k}.xmm == x_max);
    y_obs_xmax = snapshotList{k}.ymm(index); % mm
    y_obs_xmaxlst(k) = y_obs_xmax;
    
    %disp("Chordline Ypos. from PIV base in mm")
    CL = y_obs_xmax + y_tru_xmax; % mm
    CLlst(k) = CL;
    
    % initialise coordinate lists per snapshot
    x_jlst = zeros(1, length(snapshotList{k}.xmm));
    y_jlst = zeros(1, length(snapshotList{k}.xmm));
    y_tru_jlst = zeros(1, length(snapshotList{k}.xmm));
    
    for j = 1:length(snapshotList{k}.xmm)
        % x and y from data snapshot list
        x_j = snapshotList{k}.xmm(j); % mm
        x_jlst(j) = x_j;
        y_j = snapshotList{k}.ymm(j); % mm
        y_jlst(j) = y_j;
        
        % conversion perc. chord
        PER_x_j = (x_j + abs(LE))/chord; % perc. chord
        
        % true y using x from data list
        y_tru_j = CL - (y(PER_x_j) * chord); % mm
        y_tru_jlst(j) = y_tru_j;
    end
    
end

k = 1:length(snapshotList);

% plot of variation of chordline Ypos. over snapshotList
subplot(2,2,1)
plot(k, CLlst, 'o')
hold on
% formulation of linear fit
[p, S] = polyfit(k, CLlst, 1);
[CLlst_fit,delta] = polyval(p, k, S);
plot(k, CLlst_fit, 'b-')
plot(k, CLlst_fit + 2 * delta, 'r--', k, CLlst_fit - 2 * delta, 'r--')
% pretty stuff
title("Snapshot vs. Chordline Ypos.")
legend("Data", "Linear Fit", "95% Prediction Interval")
xlabel("Snapshot [-]")
ylabel("Chordline Ypos. [mm]")
axis equal

% plot of var of xmax with snapshot
subplot(2,2,2)
plot(k, x_maxlst, 'o')
hold on
% formulation of linear fit
[p, S] = polyfit(k, x_maxlst, 1);
[x_maxlst_fit,delta] = polyval(p, k, S);
plot(k, x_maxlst_fit, 'b-')
plot(k, x_maxlst_fit + 2 * delta, 'r--', k, x_maxlst_fit - 2 * delta, 'r--')
% pretty stuff
title("Snapshot vs. Maximum X")
legend("Data", "Linear Fit", "95% Prediction Interval")
xlabel("Snapshot [-]")
ylabel("Maximum X [mm]")
axis equal

% plot of var of xmax and y pos of xmas over all snapshots
subplot(2,2,3)
plot(x_maxlst, y_obs_xmaxlst, 'o')
title("X, Y pos. data for X max over all Snapshots")
xlabel("Maximum X [mm]")
ylabel("Y at Maximum X [mm]")
axis equal


subplot(2,2,4)
plot(x_jlst, y_jlst, 'ro', x_jlst, y_tru_jlst, 'bx')
hold on
% poly fit observed data to same degree 4

[p, S] = polyfit(x_jlst, y_jlst, 1);
[x_jlst_fit,delta] = polyval(p, x_jlst, S);
%plot(x_jlst, x_jlst_fit, 'b-') 
%plot(x_jlst, x_jlst_fit + 2 * delta, 'r--', x_jlst, x_jlst_fit - 2* delta, 'r--')
title("X, Y pos. data at Snapshot 100")
legend("Observed", "True")
xlabel("X [mm]")
ylabel("Y [mm]")
axis equal

% use observed x to compute a true y to compare with observed y,  then form least-squares to determine error compared to
% true form.
% fit lit polyfit to same point over entire time.





