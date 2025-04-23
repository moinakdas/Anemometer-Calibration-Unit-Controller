%add subdirectories & load libraries
clear all; %#ok<CLALL>
clc;

addpath("lib");
addpath("core");
addpath("wrappers");
loadphidget21;

% Pull data from JSON file
yawID = 753483;
pitchID = 753327;
gateID = 753486;
interfaceID = 705654;

% Initialize all phidget handles and connection status variables
[interfaceHandle,yawHandle,pitchHandle,gateHandle,interfaceConn,yawConn,pitchConn,gateConn] = init_wrapper(interfaceID,yawID,pitchID,gateID);
fprintf('\n');
try
    % Zero out motors, define global vars
    
    % Move all motors
    moveto(yawHandle, 00)
    moveto(pitchHandle, 000)
    pause(1)
    %moveto(pitchHandle, 0)
    pause(1)
    % Execute movements from list + data collection/output

    %Cleanup
    fprintf('\n');
    cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,yawHandle,pitchHandle,gateHandle,interfaceHandle);

catch ME
    % Cleanup on error
    fprintf('Error in %s at line %d: %s\n', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf('\n');
    cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,yawHandle,pitchHandle,gateHandle,interfaceHandle);
end


%26400 = touching wall next to hole
%4800 = covering hole middle
%0 = touching opposite wall