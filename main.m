%add subdirectories & load libraries
clear all; %#ok<CLALL>
clc;

addpath("lib");
addpath("core");
addpath("wrappers");
loadphidget21;

% Pull data from JSON file
yawID = 753483;
pitchID = 753486;
gateID = 753327;
interfaceID = 705654;

% Set hashmaps for steps
gateStepMap = containers.Map('KeyType', 'char', 'ValueType', 'int32');
gateStepMap('zero') = -1;
gateStepMap('center') = -1;
gateStepMap('inlet') = -1;
gateStepMap('max') = -1;

yawStepMap('zero') = -1;
yawStepMap('center') = -1;
yawStepMap('max') = -1;

pitchStepMap('zero') = -1;
pitchStepMap('center') = -1;
pitchStepMap('max') = -1;
% Variable initialization


% Initialize all phidget handles and connection status variables
[interfaceHandle,yawHandle,pitchHandle,gateHandle,interfaceConn,yawConn,pitchConn,gateConn] = init_wrapper(interfaceID,yawID,pitchID,gateID);
fprintf('\n');
try
    %Zero motors
    yawZeroStep = zeroMotor(interfaceHandle, yawHandle,2000,-1000,0);
    fprintf("Yaw motor zeroed at %d\n", yawZeroStep);
    gateZeroStep = zeroMotor(interfaceHandle, gateHandle,500,-250,2);
    fprintf("Gate motor zeroed at %d\n", gateZeroStep);
    % Execute movements from list + data collection/output

    %Return to zero
    moveto(yawHandle, yawZeroStep - 52000);
    moveto(gateHandle, gateZeroStep - 12000);
    % Cleanup
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