function snapshotList = importSnapshotList(filename, prevline, afterline)
snapshotList = {};

fid = fopen(filename);

start = -1;

i = 0;
while true
    i = i + 1;
    line = fgetl(fid);  % read line excluding newline character
    
    if line == -1
        snapshotList{end+1} = importSnapshot(filename, [start, i - 1]);
        break
    elseif startsWith(line, prevline)
        start = i + 1;
    elseif startsWith(line, afterline) && start ~= -1
        snapshotList{end+1} = importSnapshot(filename, [start, i - 1]);
    end
end

fclose(fid);
end
