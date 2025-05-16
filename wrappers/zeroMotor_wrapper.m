function [pitchZeroStep,yawZeroStep,gateZeroStep] = zeroMotor_wrapper(interfaceHandle,pitchHandle, yawHandle,gateHandle)
    
    pitchForwardStep = 2000;
    pitchBackwardStep = -500;
    pitchLimitSW = 1;

    yawForwardStep = 2000;
    yawBackwardStep = -1000;
    yawLimitSW = 0;

    gateForwardStep = 500;
    gateBackwardStep = -250;
    gateLimitSW = 2;
    
    pitchZeroStep = zeroMotor(interfaceHandle, pitchHandle, pitchForwardStep, pitchBackwardStep, pitchLimitSW);
    fprintf('Pitch motor zeroed at %d\n', pitchZeroStep);
    drawnow;
    moveto(pitchHandle, pitchZeroStep - 30000);

    yawZeroStep = zeroMotor(interfaceHandle, yawHandle,yawForwardStep,yawBackwardStep,yawLimitSW);
    fprintf('Yaw motor zeroed at %d\n', yawZeroStep);
    drawnow;
    moveto(yawHandle, yawZeroStep - 40000);

    gateZeroStep = zeroMotor(interfaceHandle, gateHandle,gateForwardStep,gateBackwardStep,gateLimitSW);
    fprintf('Gate motor zeroed at %d\n', gateZeroStep);
    drawnow;
    moveto(gateHandle, gateZeroStep - 12000);

    fprintf('\n[LOCALIZATION SUCCESS] All motors set to neutral position, ready to execute set\n');
    drawnow;

end