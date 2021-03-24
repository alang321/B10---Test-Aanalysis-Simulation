function  givemeAOA(t0,t1,list)
%GIVEMEAOA Summary of this function goes here
%   t0 is the start time, t1 is the end time, dt is the sampling rate, list
%   refers to the case (snapshotList 0-1-2)
n=(t1-t0)/0.01;
t=t0:0.01:t1;
a0=t0*100;
aoa_flap = single.empty(n+1,0);
aoa_main = single.empty(n+1,0);
aoa_flap(1)=0;
aoa_main(1)=0;
for i=1:n
    [aoa_main(i+1),aoa_flap(i+1)]=linear(list,a0+i);

end
hold on
plot(t,aoa_flap);
plot(t,aoa_main);
hold off
legend('aoa flap','aoa main')
end

