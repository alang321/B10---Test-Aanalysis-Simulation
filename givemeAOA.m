function  givemeAOA(t0,t1,dt,list)
%GIVEMEAOA Summary of this function goes here
%   t0 is the start time, t1 is the end time, dt is the sampling rate, list
%   refers to the case (snapshotList 0-1-2)
n=(t1-t0)/dt;
t=t0:dt:t1;
a0=t0*100;
aoa_flap = single.empty(n+1,0);
aoa_main = single.empty(n+1,0);
aoa_flap(1)=0;
aoa_main(1)=0;
for i=1:n
    aoa_flap(i+1)=linear(list,6,8,a0+i);
    aoa_main(i+1)=linear(list,2,5,a0+i);
end
hold on
plot(t,aoa_flap);
plot(t,aoa_main);
hold off
legend('aoa flap','aoa main')
end

