function daqSession = initializeDAQ()
s = daq.createSession('dt');
s.addAnalogInputChannel('DT9834(00)', 0, 'Voltage');
s.Rate = 1000;
s.DurationInSeconds = 2;
daqSession = s;
end