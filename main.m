%add subdirectories & load libraries
clear all; %#ok<CLALL>
clc;

addpath("phidget_libs")
addpath("user_functions")
loadphidget21;

% Global vars
yawConn = false; %true if yaw motor is initialized successfully
pitchConn = false; %true if pitch motor is initialized successfully
gateConn = false; %true if gate motor is initialized successfully
interfaceConn = false; %true if interface is initialized successfully

% Pull data from JSON file
yawID = 753483;
pitchID = 753327;
gateID = 753486;
interfaceID = 705654;

% Initialize all motors & Interface kit
try
    interfaceHandle = initializeInterface(interfaceID); % INTERFACE INIT
    interfaceConn = true;                               % INTERFACE INIT
    disp("Interface initialization SUCCESSFUL!");       % INTERFACE INIT
catch ME                                                % INTERFACE INIT
    fprintf('Error in %s at line %d: %s\n', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    disp("Interface initialization FAILED!");           % INTERFACE INIT
end                                                     % INTERFACE INIT
fprintf("\n");                                          % INTERFACE INIT

try
    yawHandle = initialize(yawID);                 % YAW MOTOR INIT
    yawConn = true;                                % YAW MOTOR INIT
    disp("Yaw motor initialization SUCCESSFUL!");  % YAW MOTOR INIT
catch ME                                           % YAW MOTOR INIT
    disp("Yaw motor initialization FAILED!");      % YAW MOTOR INIT
end                                                % YAW MOTOR INIT
fprintf("\n");                                     % YAW MOTOR INIT

try
    pitchHandle = initialize(pitchID);               % PITCH MOTOR INIT
    pitchConn = true;                                % PITCH MOTOR INIT
    disp("Pitch motor initialization SUCCESSFUL!");  % PITCH MOTOR INIT
catch ME                                             % PITCH MOTOR INIT
    disp("Pitch motor initialization FAILED!");      % PITCH MOTOR INIT
end                                                  % PITCH MOTOR INIT
fprintf("\n");                                       % PITCH MOTOR INIT

try
    gateHandle = initialize(gateID, 11000);        % GATE MOTOR INIT
    gateConn = true;                               % GATE MOTOR INIT
    disp("Gate motor initialization SUCCESSFUL!"); % GATE MOTOR INIT
catch ME                                           % GATE MOTOR INIT
    disp("Gate motor initialization FAILED!");     % GATE MOTOR INIT
end                                                % GATE MOTOR INIT
fprintf("\n");                                     % GATE MOTOR INIT

try
    % Zero out motors, define global vars
    
    % Move all motors

    % Execute movements from list + data collection/output

    %Cleanup
    if yawConn
        cleanup(yawHandle);
        disp("Yaw motor disengagement SUCCESS!");
        yawConn = false;
    end
    if pitchConn
        cleanup(pitchHandle);
        disp("Pitch motor disengagement SUCCESS!");
        pitchConn = false;
    end
    if gateConn
        cleanup(gateHandle);
        disp("Gate motor disengagement SUCCESS!");
        gateConn = false;
    end
    if interfaceConn
        cleanupInterface(interfaceHandle);
        disp("Interface disengagement SUCCESS!");
        interfaceConn = false;
    end

catch ME
    % Cleanup on error
    fprintf('Error in %s at line %d: %s\n', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);

    if yawConn
        cleanup(yawHandle);
        disp("Yaw motor disengagement SUCCESS!");
        yawConn = false;
    end

    if pitchConn
        cleanup(pitchHandle);
        disp("Pitch motor disengagement SUCCESS!");
        pitchConn = false;
    end

    if gateConn
        cleanup(gateHandle);
        disp("Gate motor disengagement SUCCESS!");
        gateConn = false;
    end

    if interfaceConn
        cleanupInterface(interfaceHandle);
        disp("Interface disengagement SUCCESS!");
        interfaceConn = false;
    end
end


%26400 = touching wall next to hole
%4800 = covering hole middle
%0 = touching opposite wall