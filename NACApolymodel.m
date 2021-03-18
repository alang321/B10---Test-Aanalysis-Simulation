function NACApolymodel(snapshotList)
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALISATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT SNAPSHOT NUMBER
num = 28; % between 1 and 100 for Case 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AIRFOIL DATA
chord = 0.4*1000; %mm
rot_axis = 0.3125; % x/c from LE; rotational axis of the model
T = 0.18; % percentage of chord

% POLYNOMIAL CONSTANTS
a_0 = 0.2969;
a_1 = -0.126;
a_2 = -0.3516;
a_3 = 0.2843;
a_4 = -0.1036;

% POLYNOMIAL EXPRESSION
%x is in range 0 to 1 (percentage of chord), y is measured from the chordline 0 to T/2.
y = @(x) T/0.2 * (a_0 * x.^0.5 + a_1 * x + a_2 * x.^2 + a_3 * x.^3 + a_4 * x.^4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA COLLABORATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ASSUMES THAT MAX X IS THE LAST COLUMN OF MARKERS 15 mm from TE!!!

% for loop over all snapshots, find maximum x (closest recognized marker to
% the PIV origin) to compute location of TE and therefore also the y
% position of the chordline wrt PIV origin.

% initialising vectors to append in for loop
x_maxlst = zeros(1, length(snapshotList));
y_obs_xmaxlst = zeros(1, length(snapshotList));
y_chordlst = zeros(1, length(snapshotList));

% initialise vectors per snapshot (overwrites previous
% snapshot)
col = 1;

for h = 1:length(snapshotList)
    col_new = max(length(snapshotList{h}.xmm));
    if col_new > col
        col = col_new;
    else
        col = col;
    end
end

x_jlst = zeros(length(snapshotList), col);
y_jlst = zeros(length(snapshotList), col);
y_tru_jlst = zeros(length(snapshotList), col);
%TODO: Implement the j lists to add over entire snapshot list.

fprintf(1,'Expect Two Processes:\n\n');

fprintf(1,'Computation Progress: %3d%%\n',0);
for k = 1:length(snapshotList)
    % iteration number (use semicolon to prevent printing)
    k;
    % progress
    %disp("Computations " + round(k/length(snapshotList), 2) * 100 + " %")
    
    fprintf(1,'\b\b\b\b%3.0f%%',round(k/length(snapshotList), 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
    
    % obtaining xmax from each snapshot and appending to list:
    x_max = max(snapshotList{k}.xmm); % mm
    x_maxlst(k) = x_max;
   
    % trailing- and leading edge x coordinate computations (ONLY VALID IF XMAX IS TRUELY
    % THE LAST MARKER TO THE TE); PIV csys.
    TE = x_max + 15; % mm
    LE = TE - 400; % mm

    % provides xmax as a percentage of the chord; LE x-coord - x_max coord.
    % = distance of x_max from LE in mm
    PER_x_max = (abs(LE) + x_max)/chord; % perc. chord

    % TRUE y (measured from chordline; i.e. thickness of airfoil) at x_max in mm
    y_tru_xmax = y(PER_x_max) * chord; % mm

    % OBSERVED y (measured from PIV origin i.e. coordinate to airfoil surface) at x_max in mm
    index = find(snapshotList{k}.xmm == x_max);
    y_obs_xmax = snapshotList{k}.ymm(index); % mm
    % appending all observed y at xmax to vector
    y_obs_xmaxlst(k) = y_obs_xmax;
    
    % resulting composition to calculate the y coordinate of the chordline
    % from the PIV origin.
    y_chord = y_obs_xmax + y_tru_xmax; % mm
    y_chordlst(k) = y_chord;
    
    % initialise vectors per snapshot (overwrites previous
    % snapshot) OUTDATED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %x_jlst = zeros(1, length(snapshotList{k}.xmm));
    %y_jlst = zeros(1, length(snapshotList{k}.xmm));
    %y_tru_jlst = zeros(1, length(snapshotList{k}.xmm));
    
    % loops over all x values in the current snapshot k
    for j = 1:col
        if length(snapshotList{k}.xmm) >= j
            % OBSERVED x and y from data snapshot list to vectors
            x_j = snapshotList{k}.xmm(j); % mm
            x_jlst(k, j) = x_j;
            y_j = snapshotList{k}.ymm(j); % mm
            y_jlst(k, j) = y_j;
        elseif length(snapshotList{k}.xmm) < j
            % Empty to vectors when matrice row length too long
            x_jlst(k, j) = inf;
            y_jlst(k, j) = inf;
        end
        
        % OBSERVED x coordinate values as percentage of the chord
        % provides x as a percentage of the chord; LE x-coord - x coord.
        % = distance of x from LE in mm
        PER_x_j = (abs(LE) + x_j)/chord; % perc. chord
        
        % TRUE y using OBSERVED x and AIRFOIL POLYNOMIAL using y_chord as
        % the basis of the polynomial (adjusted in y).
        y_tru_j = y_chordlst(k) - (y(PER_x_j) * chord); % mm
        y_tru_jlst(k, j) = y_tru_j;
    end
    % TODO: PLOT ALL X Y DATA ON ONE XYPLANE
end
fprintf('\n\n'); % To go to a new line after reaching 100% progress

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% progress status
fprintf(1,'Plot Progress: %3d%%\n',0);
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(0/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

% X, Y pos. data for X max over all Snapshots
subplot(2,2,[1 3])
plot(x_maxlst, y_obs_xmaxlst, 'o')
hold on 
% superimposing the NACA 0018 polynomial with TE at most frequently
% observed x coordinate for the TE over all snapshots and the chordline at
% the most frequently observed y coordinate for the chord over all
% snapshots
x = linspace(0, 1, 1000);

x_TEfromOrigin = mode(x_maxlst + 15); % mm
y_TEfromOrigin = mode(y_chordlst); % mm

plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
title("X, Y pos. data for X MAX points in all Snapshots")
legend("XMAX Points", "NACA0018")
xlabel("X [mm]")
ylabel("Y [mm]")
axis equal
set(gca,'XLim',[TE-280 TE],'YLim',[500 700])
hold off
% TODO: MODE OR MEDIAN??
% TODO: plot of variation of XMAX over the snapshots (time)


% progress status
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(1/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

%Snapshot vs. Observed X Data Closest to the Origin
subplot(2,2,2)
% initialise the vector space
k = 1:length(snapshotList);
plot(k, x_maxlst, 'o')
hold on
% formulation of linear fit
[p, S] = polyfit(k, x_maxlst, 1);
[x_maxlst_fit,delta] = polyval(p, k, S);
plot(k, x_maxlst_fit, 'b-')
plot(k, x_maxlst_fit + 2 * delta, 'r--', k, x_maxlst_fit - 2 * delta, 'r--')
% pretty stuff
title("Snapshot vs. Observed X MAX Data")
legend("Observed Data", "Linear Fit", "95% Prediction Interval")
xlabel("Snapshot [-]")
ylabel("Maximum X [mm]")
%axis equal
%set(gca,'XLim',[0 100],'YLim',[TE-280 TE])
% TODO: plot without data above the average
annotation('textbox',[0.3 0.0 0.2 0.3],'String','Note: Chordline pos. not correlated to Y coord. of XMAX; represents TE','EdgeColor','none')


% progress status
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(3/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

% Snapshot vs. Y Position of Airfoil Chordline (time)
subplot(2,2,4)
plot(k, y_chordlst, 'o')
hold on
% formulation of linear fit
[p, S] = polyfit(k, y_chordlst, 1);
[CLlst_fit,delta] = polyval(p, k, S);
plot(k, CLlst_fit, 'b-')
plot(k, CLlst_fit + 2 * delta, 'r--', k, CLlst_fit - 2 * delta, 'r--')
% pretty stuff
title("Snapshot vs. Y Position of Airfoil Chordline")
legend(" Observed Data Computed with XMAX", "Linear Fit", "95% Prediction Interval")
xlabel("Snapshot [-]")
ylabel("Y Position of Chordline [mm]")
%axis equal
% TODO: plot without values below the average.

%%
% initialize new figure
figure

% progress status
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(4/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

% X, Y pos. data at Snapshot num in the Robot PIV csys.
subplot(1,2,1)
plot(x_jlst(num,:), y_jlst(num,:), 'ro', x_jlst(num,:), y_tru_jlst(num,:), 'bx')
hold on
x_TEfromOrigin = x_maxlst(num) + 15; % mm
y_TEfromOrigin = y_chordlst(num); % mm
plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
title("X, Y pos. data at Snapshot " + num + " in the Robot PIV csys.")
legend("Observed", "True")
xlabel("X [mm]")
ylabel("Y [mm]")
axis equal
set(gca,'XLim',[TE-280 TE],'YLim',[500 700])


% progress status
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(5/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

% k-median clustering plot in PIV csys.
subplot(1,2,2)
% putting vector x and y observation data into matrix
%matrix_xy = [transpose(x_jlst(num,:)),transpose(y_jlst(num,:))];
matrix_xy = [snapshotList{num}.xmm,snapshotList{num}.ymm];
% using k-median clustering algorithm to determine the centroids of 8
% cluster groups representing the 8 markers in the x-y plane
[idx, C] = kmedoids(matrix_xy, 8);
% plotting each of the 8 observed clusters
plot(matrix_xy(idx==1, 1), matrix_xy(idx==1, 2), 'redo')
hold on
plot(matrix_xy(idx==2, 1), matrix_xy(idx==2, 2), 'greeno')
plot(matrix_xy(idx==3, 1), matrix_xy(idx==3, 2), 'blueo')
plot(matrix_xy(idx==4, 1), matrix_xy(idx==4, 2), 'magentao')
plot(matrix_xy(idx==5, 1), matrix_xy(idx==5, 2), 'yellowo')
plot(matrix_xy(idx==6, 1), matrix_xy(idx==6, 2), 'cyano')
plot(matrix_xy(idx==7, 1), matrix_xy(idx==7, 2), 'greeno')
plot(matrix_xy(idx==8, 1), matrix_xy(idx==8, 2), 'blacko')
% plotting the centroids of the 8 observed clusters
plot(C(:,1), C(:,2), 'kx','MarkerSize',12)
plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
hold off
title("X, Y pos. data at Snapshot " + num)
legend("Cluster 1", "Cluster 2","Cluster 3", "Cluster 4","Cluster 5", "Cluster 6","Cluster 7", "Cluster 8", "Cluster Centroids", 'Location','Southoutside')
xlabel("X [mm]")
ylabel("Y [mm]")
axis equal
set(gca,'XLim',[TE-280 TE],'YLim',[500 700])

%%  

% initialize new figure
figure

% progress status
for h = 1:1:8
    fprintf(1,'\b\b\b\b%3.0f%%',round(6/8, 3) * 100); % Deleting 4 characters (The three digits and the % symbol)
end

% x and y plot for snapshot in airfoil csys.
%subplot(1,2,2)
% x coord. of TE determed from k-median clustering in PIV csys.
x_kTE = max(C(:,1)) + 15; % mm
% x coord. transformation of TE to rotation axis csys.
x_krot = x_kTE - (400 - rot_axis * chord);  % mm
%x_rotlst = x_jlst + abs(x_krot);
x_rotlst = snapshotList{num}.xmm + abs(x_krot);
% plotting
plot(x_rotlst, snapshotList{num}.ymm , 'ro', x_rotlst, y_tru_jlst(num, 1:length(snapshotList{num}.ymm)), 'blackx', "MarkerSize",8)
hold on
% superimposing the NACA 0018 polynomial
x = linspace(0, 1, 1000);
%x_TEfromOrigin = 400 - rot_axis * chord;  % mm
x_TEfromOrigin = x_maxlst(num)+ 15 - x_krot; % mm
y_TEfromOrigin = y_chordlst(num); % mm
plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
title("X, Y pos. data at Snapshot " + num + " Origin at the Rotation Axis.")
legend("Observed", "True", "NACA0018 Polynomial")
xlabel("X [mm]")
ylabel("Y [mm]")
axis equal
set(gca,'XLim',[0 280],'YLim',[500 700])
hold off

% TODO: Add simplified graph with cluster centroids

%%

% initialie new figure
figure



for num = 1:length(snapshotList)
    % k-median clustering plot in PIV csys.
   
    % progress status
    fprintf(1,'\b\b\b\b%3.0f%%',round( num/length(snapshotList) * ( 1 - round(7/8, 3) ) + round(7/8, 3), 3)  * 100); % Deleting 4 characters (The three digits and the % symbol)

    hold on
    subplot(1,2,1)
    % putting vector x and y observation data into matrix
    %matrix_xy = [transpose(x_jlst(num,:)),transpose(y_jlst(num,:))];
    matrix_xy = [snapshotList{num}.xmm,snapshotList{num}.ymm];
    % using k-median clustering algorithm to determine the centroids of 8
    % cluster groups representing the 8 markers in the x-y plane
    [idx, C] = kmedoids(matrix_xy, 8);
    % plotting each of the 8 observed clusters
    plot(matrix_xy(idx==1, 1), matrix_xy(idx==1, 2), 'o')
    plot(matrix_xy(idx==2, 1), matrix_xy(idx==2, 2), 'o')
    plot(matrix_xy(idx==3, 1), matrix_xy(idx==3, 2), 'o')
    plot(matrix_xy(idx==4, 1), matrix_xy(idx==4, 2), 'o')
    plot(matrix_xy(idx==5, 1), matrix_xy(idx==5, 2), 'o')
    plot(matrix_xy(idx==6, 1), matrix_xy(idx==6, 2), 'o')
    plot(matrix_xy(idx==7, 1), matrix_xy(idx==7, 2), 'o')
    plot(matrix_xy(idx==8, 1), matrix_xy(idx==8, 2), 'o')
    % plotting the centroids of the 8 observed clusters
    plot(C(:,1), C(:,2), 'kx','MarkerSize',12)
    plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
    title("X, Y pos. data at Snapshot " + num)
    %legend("Cluster 1", "Cluster 2","Cluster 3", "Cluster 4","Cluster 5", "Cluster 6","Cluster 7", "Cluster 8", "Cluster Centroids", 'Location','Southoutside')
    xlabel("X [mm]")
    ylabel("Y [mm]")
    axis equal
    set(gca,'XLim',[TE-280 TE],'YLim',[500 700])
    
    hold off
    
    hold on

    % x and y plot for snapshot in airfoil csys.
    subplot(1,2,2)
    % x coord. of TE determed from k-median clustering in PIV csys.
    x_kTE = max(C(:,1)) + 15; % mm
    % x coord. transformation of TE to rotation axis csys.
    x_krot = x_kTE - (400 - rot_axis * chord);  % mm
    %x_rotlst = x_jlst + abs(x_krot);
    x_rotlst = snapshotList{num}.xmm + abs(x_krot);
    % plotting
    %plot(x_rotlst, snapshotList{num}.ymm , 'ro', x_rotlst, y_tru_jlst(num, 1:length(snapshotList{num}.ymm)), 'blackx', "MarkerSize",8)
    plot(x_rotlst, snapshotList{num}.ymm , 'ro')
    % superimposing the NACA 0018 polynomial
    x = linspace(0, 1, 1000);
    %x_TEfromOrigin = 400 - rot_axis * chord;  % mm
    x_TEfromOrigin = x_maxlst(num)+ 15 - x_krot; % mm
    y_TEfromOrigin = y_chordlst(num); % mm
    plot(x * chord -(chord - x_TEfromOrigin), - y(x)*chord + y_TEfromOrigin, 'b--',x * chord -(chord - x_TEfromOrigin), y(x)*chord + y_TEfromOrigin, 'b--')
    title("X, Y pos. data at Snapshot " + num + " Origin at the Rotation Axis.")
    %legend("Observed", "True", "NACA0018 Polynomial")
    xlabel("X [mm]")
    ylabel("Y [mm]")
    axis equal
    set(gca,'XLim',[0 280],'YLim',[500 700])
    
    hold off
end

fprintf('\n'); % To go to a new line after reaching 100% progres


