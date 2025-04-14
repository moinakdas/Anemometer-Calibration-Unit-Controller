function stepperHandle = initialize(motorID, motorSpeed)
    if nargin < 2  % If 'b' is not provided
        motorSpeed = 20536;    % Assign default value
    end
    
    stepperHandle = libpointer('int32Ptr');
    calllib('phidget21', 'CPhidgetStepper_create', stepperHandle);


    calllib('phidget21', 'CPhidget_open', stepperHandle, -1);

    if calllib('phidget21', 'CPhidget_waitForAttachment', stepperHandle, 2500) == 0

        % Set motor parameters
        calllib('phidget21', 'CPhidgetStepper_setVelocityLimit', stepperHandle, 0, 20536);
        calllib('phidget21', 'CPhidgetStepper_setAcceleration', stepperHandle, 0, 87543);
        calllib('phidget21', 'CPhidgetStepper_setCurrentLimit', stepperHandle, 0, 1);

        % Engage the motor
        calllib('phidget21', 'CPhidgetStepper_setEngaged', stepperHandle, 0, 1);
    else
        error('Could Not Open Stepper');
    end
end