%devs = daq.getDevices;
%disp(devs);
s = daq.createSession('dt');
s.addAnalogInputChannel('DT9834(00)', 0, 'Voltage');
s.Rate = 1000;
s.DurationInSeconds = 10;
[data,time] = startForeground(s);
plot(time, data);