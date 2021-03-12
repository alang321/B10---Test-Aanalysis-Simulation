function snapshot = importSnapshot(filename, dataLines)
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 13);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["xmm", "ymm", "zmm", "I", "ums", "vms", "wms", "Vms", "trackID", "axms", "ayms", "azms", "ams"];
opts.SelectedVariableNames = ["xmm", "ymm", "zmm", "trackID"];
opts.VariableTypes = ["double", "double", "double", "string", "string", "string", "string", "string", "double", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["I", "ums", "vms", "wms", "Vms", "axms", "ayms", "azms", "ams"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["I", "ums", "vms", "wms", "Vms", "axms", "ayms", "azms", "ams"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["xmm", "ymm", "zmm", "trackID"], "ThousandsSeparator", ",");

% Import the data
snapshot = readtable(filename, opts);

end


