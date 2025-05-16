function [interfaceHandle,yawHandle,pitchHandle,gateHandle,daqHandle,interfaceConn,yawConn,pitchConn,gateConn,daqConn] = init_wrapper(interfaceID,yawID,pitchID,gateID)
% add comments my ass just figure it out
% Initialize all motors & Interface kit
    interfaceHandle = [];
    yawHandle = [];
    pitchHandle = [];
    gateHandle = [];
    daqHandle = [];

    daqConn = false;
    interfaceConn = false;
    yawConn = false;
    pitchConn = false;
    gateConn = false;
    
    try
        interfaceHandle = initializeInterface(interfaceID); % INTERFACE INIT
        interfaceConn = true;                               % INTERFACE INIT
        fprintf('Interface initialization SUCCESS!\n');       % INTERFACE INIT
        drawnow;                                            % INTERFACE INIT
    catch ME                                                % INTERFACE INIT
        fprintf('Interface initialization FAILED!\n');        % INTERFACE INIT
        drawnow;                                            % INTERFACE INIT
    end                                                     % INTERFACE INIT
    
    try
        yawHandle = initialize(yawID);                      % YAW MOTOR INIT
        yawConn = true;                                     % YAW MOTOR INIT
        fprintf('Yaw motor initialization SUCCESS!\n');       % YAW MOTOR INIT
        drawnow;                                            % YAW MOTOR INIT
    catch ME                                                % YAW MOTOR INIT
        fprintf('Yaw motor initialization FAILED!\n');        % YAW MOTOR INIT
        drawnow;                                            % YAW MOTOR INIT
    end                                                     % YAW MOTOR INIT
    
    try
        pitchHandle = initialize(pitchID);                  % PITCH MOTOR INIT
        pitchConn = true;                                   % PITCH MOTOR INIT
        fprintf('Pitch motor initialization SUCCESS!\n');     % PITCH MOTOR INIT
        drawnow;                                            % PITCH MOTOR INIT
    catch ME                                                % PITCH MOTOR INIT
        fprintf('Pitch motor initialization FAILED!\n');      % PITCH MOTOR INIT
        drawnow;                                            % PITCH MOTOR INIT
    end                                                     % PITCH MOTOR INIT
    
    try
        gateHandle = initialize(gateID, 11000);             % GATE MOTOR INIT
        gateConn = true;                                    % GATE MOTOR INIT
        fprintf('Gate motor initialization SUCCESS!\n');      % GATE MOTOR INIT
        drawnow;                                            % GATE MOTOR INIT
    catch ME                                                % GATE MOTOR INIT
        fprintf('Gate motor initialization FAILED!\n');       % GATE MOTOR INIT
        drawnow;                                            % GATE MOTOR INIT
    end                                                     % GATE MOTOR INIT

    try
        daqHandle = initializeDAQ();                          % DAQ INIT
        daqConn = true;                                       % DAQ INIT
        fprintf('Data Acquisition initialization SUCCESS!\n');  % DAQ INIT
        drawnow;                                              % DAQ INIT
    catch ME                                                  % DAQ INIT
        fprintf('Data Acquisition initialization FAILED!\n');
        fprintf('\nWARNING: PID control will be turned off for this session\n');   % DAQ INIT
        drawnow;                                              % DAQ INIT
    end                                                       % DAQ INIT
end