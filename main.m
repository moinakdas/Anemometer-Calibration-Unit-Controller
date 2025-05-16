%add subdirectories & load libraries
clear all;
clc;

addpath('lib');
addpath('core');
addpath('wrappers');
loadphidget21;

% Pull data from JSON file
yawID = 753483;
pitchID = 753486;
gateID = 753327;
interfaceID = 705654;

% Variable initialization


% Initialize all phidget handles and connection status variables
[interfaceHandle,yawHandle,pitchHandle,gateHandle,daqHandle,interfaceConn,yawConn,pitchConn,gateConn,daqConn] = init_wrapper(interfaceID,yawID,pitchID,gateID);

if yawConn && pitchConn && gateConn && interfaceConn
    fprintf('\n[INIT SUCCESS] All components initialized successfully, proceeding to zero motors\n\n')
    drawnow;
else
    fprintf('[INIT FAIL]')
    drawnow;
end

try    
    %Zero motors
    [pitchZeroStep,yawZeroStep,gateZeroStep] = zeroMotor_wrapper(interfaceHandle, pitchHandle, yawHandle, gateHandle);
    
    % Execute movements from configSet
    configSet = [0 0 18; 0 0 10];
    runConfigurationSet(configSet,15,yawHandle,pitchHandle,gateHandle,yawZeroStep,pitchZeroStep,daqHandle,gateZeroStep);

    % Return all motors to neutral position
    setAllNeutral(yawHandle,pitchHandle,gateHandle,yawZeroStep,pitchZeroStep,gateZeroStep)

    % Cleanup
    fprintf('\n');
    cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,daqConn,yawHandle,pitchHandle,gateHandle,interfaceHandle);

catch ME
    % Cleanup on error
    fprintf('Error in %s at line %d: %s\n', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf('\n');
    drawnow;
    
    setAllNeutral(yawHandle,pitchHandle,gateHandle,yawZeroStep,pitchZeroStep,gateZeroStep)
    cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,yawHandle,daqConn,pitchHandle,gateHandle,interfaceHandle);
end


%26400 = touching wall next to hole
%4800 = covering hole middle
%0 = touching opposite wall