function position = getMotorPos(motorHandle)
% getMotorPos Gets the current position of a Phidget stepper motor
%   position = getMotorPos(motorHandle)
%   Returns the current motor position (in steps).
%   Throws an error if reading fails.

    % Motor index (usually 0 unless you have multiple)
    motorIndex = 0;

    % Create a pointer to store the position (int64)
    posPtr = libpointer('int64Ptr', 0);

    % Get the current position
    result = calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', motorHandle, motorIndex, posPtr);

    % Check for errors
    if result ~= 0
        error('Failed to get stepper motor position (Phidget error code: %d)', result);
    end

    % Return the position value
    position = posPtr.Value;
end