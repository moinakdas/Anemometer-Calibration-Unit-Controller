%add subdirectories
addpath("phidget_libs")
addpath("user_functions")
loadphidget21;

% Pull data from JSON file
yawID = 753483;
pitchID = 753327;
gateID = 753486;

% Initialize all motors
yawHandle = initialize(yawID);
pitchHandle = initialize(pitchID);
gateHandle = initialize(gateID, 11000);

% Zero out motors, define global vars

% Move all motors
%moveto(pitchHandle, 0)
%moveto(gateHandle, 0);
%moveto(yawHandle, 0);

% Execute movements from list + data collection/output


% Cleanup
cleanup(yawHandle)
cleanup(pitchHandle)
cleanup(gateHandle)



%26400 = touching wall next to hole
%4800 = covering hole middle
%0 = touching opposite wall