function [interfaceHandle,yawHandle,pitchHandle,gateHandle,interfaceConn,yawConn,pitchConn,gateConn] = init_wrapper(interfaceID,yawID,pitchID,gateID)
% add comments my ass just figure it out
% Initialize all motors & Interface kit
    interfaceHandle = [];
    yawHandle = [];
    pitchHandle = [];
    gateHandle = [];

    interfaceConn = false;
    yawConn = false;
    pitchConn = false;
    gateConn = false;
    
    try
        interfaceHandle = initializeInterface(interfaceID); % INTERFACE INIT
        interfaceConn = true;                               % INTERFACE INIT
        disp("Interface initialization SUCCESS!");          % INTERFACE INIT
        drawnow;
    catch ME                                                % INTERFACE INIT
        disp("Interface initialization FAILED!");           % INTERFACE INIT
        drawnow;
    end                                                     % INTERFACE INIT
    
    try
        yawHandle = initialize(yawID);                      % YAW MOTOR INIT
        yawConn = true;                                     % YAW MOTOR INIT
        disp("Yaw motor initialization SUCCESS!");          % YAW MOTOR INIT
        drawnow;
    catch ME                                                % YAW MOTOR INIT
        disp("Yaw motor initialization FAILED!");           % YAW MOTOR INIT
        drawnow;
    end                                                     % YAW MOTOR INIT
    
    try
        pitchHandle = initialize(pitchID);                  % PITCH MOTOR INIT
        pitchConn = true;                                   % PITCH MOTOR INIT
        disp("Pitch motor initialization SUCCESS!");        % PITCH MOTOR INIT
        drawnow;
    catch ME                                                % PITCH MOTOR INIT
        disp("Pitch motor initialization FAILED!");         % PITCH MOTOR INIT
        drawnow;
    end                                                     % PITCH MOTOR INIT
    
    try
        gateHandle = initialize(gateID, 11000);             % GATE MOTOR INIT
        gateConn = true;                                    % GATE MOTOR INIT
        disp("Gate motor initialization SUCCESS!");         % GATE MOTOR INIT
        drawnow;
    catch ME                                                % GATE MOTOR INIT
        disp("Gate motor initialization FAILED!");          % GATE MOTOR INIT
        drawnow;
    end                                                     % GATE MOTOR INIT
end