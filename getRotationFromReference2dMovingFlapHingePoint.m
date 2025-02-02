function [anglesBody, xPosBody, anglesFlap, xPosFlap, errorsx] = getRotationFromReference2dMovingFlapHingePoint(ref, medianList, refHingePoint)

anglesBody = {};
xPosBody = {};

anglesFlap = {};
xPosFlap = {};

errorsx = {};

flapref = [ref(:,[6:8]) refHingePoint];
bodyref = ref(:,[1:5]);

for i = 1:length(medianList)
    [m, n] = size(medianList{i});
    if n == 8
        body = medianList{i}(:,[1:5]);
        
        
        a = absor(bodyref, body);
        anglesBody{end+1} = rad2deg(asin(a.R(2, 1)));
        xPosBody{end+1} = i/100;
        
        hingeNew = a.R * refHingePoint + a.t;
        
        flap = [medianList{i}(:,[6:8]) hingeNew];
        
        a = absor(flapref, flap);
        anglesFlap{end+1} = rad2deg(asin(a.R(2, 1)));
        xPosFlap{end+1} = i/100;
        
        
        %rotatedFlapRef = a.R * flapref + a.t;
        %scatter(body(1,:), body(2,:))
        %hold on
        %scatter(rotatedFlapRef(1,:), rotatedFlapRef(2,:))
        %scatter(flap(1,:), flap(2,:))
        %hold off
        %set(gca,'XLim',[-800 -400],'YLim',[500 700])
    else
        errorsx{end+1} = i/100;
    end
end