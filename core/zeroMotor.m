function zeroIndex = zeroMotor(interfaceHandle, motorHandle,delta_1, delta_2, inputIndex)
% zeroMotor Zeroes a motor using a limit switch
%   Moves motor forward until limit switch is hit, then back until disengaged.
%   Returns the final motor position as the zero reference.

    % --- Configuration ---
    pauseTime = 0.001;    % Pause duration between movements (in seconds)

    % === Move toward limit switch until it's triggered ===
    while ~readPin(interfaceHandle, inputIndex)
        moveRelative(motorHandle, delta_1);
        pause(pauseTime);
    end
    % fprintf('Limit switch engaged.\n');

    % === Back off until switch is disengaged ===
    while readPin(interfaceHandle, inputIndex)
        moveRelative(motorHandle, delta_2);
        pause(pauseTime);
    end

    % fprintf('Limit switch released.\n');

    % === Record current position as zero ===
    zeroIndex = getMotorPos(motorHandle);
end