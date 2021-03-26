function [angles, xPos, errorsx] = getRotationFromReference2dFixedFlap(ref, medianList)

angles = {};
xPos = {};

errorsx = {};
for i = 1:length(medianList)
    
    try
        a = absor(ref, medianList{i});
        angles{end+1} = rad2deg(asin(a.R(2, 1)));
        xPos{end+1} = i/100;
    catch ME
        errorsx{end+1} = i/100;
    end
end