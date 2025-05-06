function moveRelative(motorHandle, delta)
% moveRelative Moves a stepper motor relative to its current position
%   moveRelative(motorHandle, delta)
%   Positive delta moves counterclockwise, negative clockwise.

    if nargin < 2
        error('Two arguments required: motorHandle and delta.');
    end

    % Get current position
    currentPos = getMotorPos(motorHandle);

    % Compute target position
    targetPos = currentPos + delta;

    % Move to the target position
    moveto(motorHandle, targetPos);
end