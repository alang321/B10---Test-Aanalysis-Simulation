%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loading Rigid-Body Comparison Angle of Attack Comparison


load('RigidAngleComparison/case2/xBody.mat')
load('RigidAngleComparison/case2/anglesBody.mat')
load('RigidAngleComparison/case2/anglesFlap.mat')
load('RefData/XDataReference.mat')
load('RefData/XDataReferenceFlap.mat')
load('RefData/YDataReference.mat')
load('RefData/YDataReferenceFlap.mat')

load('RigidAngleComparison/FINAL/xPos.mat')
load('RigidAngleComparison/FINAL/bod.mat')

% Functions for plotting
xBody = xPos;
anglesBody = bod;
%xBody = cell2mat(xPos);
%anglesBody = cell2mat(bod);
%anglesFlap = cell2mat(anglesFlap);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot OBSERVED data


% BODY AoA
%plot(xBody, anglesBody, 'rx')
%title('Observed Body')


% FLAP Def
%figure 
%plot(xBody, anglesFlap, 'rx')
%title('Observed Flap')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot OBSERVED data in one period


% BODY
%figure
% Normalizing period of observed data in phase with ref. data
initialindex = min(find(abs(anglesBody) < 0.03));
finalindex = find(xBody == xBody(initialindex) + 2.5);
periodxBody = xBody(initialindex: finalindex);
periodanglesBody = anglesBody(initialindex:finalindex);
normperiodxBody = (periodxBody-periodxBody(1))/2.5;

%plot(periodxBody, periodanglesBody, 'rx')
%title('Observed Body Period')


% FLAP
%figure
% Normalizing period of observed data in phase with ref. data
%initialindex = min(find(abs(anglesFlap) < 0.03));
%finalindex = find(xBody == xBody(initialindex) + 2.5);
%periodxBody = xBody(initialindex: finalindex);
%periodanglesFlap = anglesFlap(initialindex:finalindex);
%normperiodxBody = (periodxBody-periodxBody(1))/2.5;

%plot(periodxBody, periodanglesFlap, 'rx')
%title('Observed Flap Period')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot OBSERVED data in normalized period


% BODY
figure
%plot(XDataReference, YDataReference, 'ko')
hold on
xnew = normperiodxBody;
ynew = interp1(XDataReference, YDataReference, xnew, 'spline');

plot(xnew, ynew, 'b-')
plot(normperiodxBody, periodanglesBody, 'rx')
%title('Norm Body')
xlabel('Normalized Time Period [-]')
ylabel('Angle of Attack [deg]')
legend("True", "Observed")
ylim([-6 6])

% FLAP
%figure
%hold on
%xnew = normperiodxBody;
%ynew = interp1(XDataReferenceFlap, YDataReferenceFlap, xnew, 'spline');

%plot(xnew, ynew, 'b-')
%plot(normperiodxBody, periodanglesFlap, 'rx')
%title('Norm Flap')
%xlabel('Normalized Time Period [-]')
%ylabel('Angle of Attack [deg]')
%legend("True", "Observed")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot STD of OBSERVED vs. REF.


% BODY
stdtrue = std(ynew - periodanglesBody,1);
meantrue = mean(ynew - periodanglesBody);

disp(stdtrue)

figure 
plot(xnew, ynew - periodanglesBody - meantrue, 'bx')
hold on
yline(0, 'k--')
yline(0 - 2*stdtrue, 'r-.')
yline(0 + 2*stdtrue, 'r-.')
xlabel('Normalized Time Period [-]')
ylabel('Angle of Attack Difference [deg]')
legend("Difference between True and Observed", "Mean", "95% Confidence Interval")
%title('Std Body')


% FLAP
%stdtrue = std(ynew - periodanglesFlap,1);
%meantrue = mean(ynew - periodanglesFlap);

%figure 
%plot(xnew, ynew - periodanglesFlap - meantrue, 'bx')
%hold on
%yline(0, 'k--')
%yline(0 - 2*stdtrue, 'r-.')
%yline(0 + 2*stdtrue, 'r-.')
%xlabel('Normalized Time Period [-]')
%ylabel('Angle of Attack Difference [deg]')
%legend("Difference between True and Observed", "Mean", "95% Confidence Interval")
%title('Std Flap')
%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Loading Tracker Regression Comparison Angle of Attack Comparison


%load('TrackerRegression/case2/time.mat');
%load('TrackerRegression/case2/anglesMain.mat');
%load('TrackerRegression/case2/anglesFlap.mat');

load('RefData/XDataReference.mat')
load('RefData/XDataReferenceFlap.mat')
load('RefData/YDataReference.mat')
load('RefData/YDataReferenceFlap.mat')

load('TrackerRegression/case1/main_8pts.mat');
anglesMain = main_8pts;

time = [0:0.01:36];
time = time(5:length(time));
anglesMain = anglesMain(5:length(anglesMain));
%anglesFlap = anglesFlap(5:length(anglesFlap));

% Functions for plotting
% Plot observed data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(time, anglesMain, 'rx')

%figure

%initialindex = find(xBody == 1.25)
initialindex = min(find(abs(anglesMain) < 0.03));
finalindex = find(time == time(initialindex) + 2.5);

periodtime = time(initialindex: finalindex);
periodanglesMain = anglesMain(initialindex:finalindex);
%periodanglesFlap = anglesFlap(initialindex:finalindex);

normperiodtime = (periodtime-periodtime(1))/2.5;

% Plot observed data in period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot(periodtime, periodanglesMain, 'rx')

%figure

%plot(XDataReference, YDataReference, 'ko')
hold on
%xnew = (0:0.005:1)';
xnew = normperiodtime;
ynew = interp1(XDataReference, YDataReference, xnew, 'spline');

plot(xnew, ynew, 'b-')
plot(normperiodtime, periodanglesMain, 'rx')

% 'Reference Data Plot; Normalized Time Period Variation of Angle of Attack'
xlabel('Normalized Time Period [-]')
ylabel('Angle of Attack [deg]')
legend("True", "Observed")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stdtrue = std(ynew - periodanglesMain,1);
meantrue = mean(ynew - periodanglesMain);

disp(stdtrue)

%figure

%plot(xnew, ynew - periodanglesMain, 'bx')
%hold on
%yline(meantrue, 'k--')
%yline(meantrue - 2*stdtrue, 'r-.')
%yline(meantrue + 2*stdtrue, 'r-.')
%legend("Difference between True and Observed", "Mean", "95% Confidence Interval")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure 

plot(xnew, ynew - periodanglesMain - meantrue, 'bx')
hold on
yline(0, 'k--')
yline(0 - 2*stdtrue, 'r-.')
yline(0 + 2*stdtrue, 'r-.')
xlim([0,1])
xlabel('Normalized Time Period [-]')
ylabel('Angle of Attack Difference [deg]')
legend("Difference between True and Observed", "Mean", "95% Confidence Interval")

