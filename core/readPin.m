function value = readPin(interfaceHandle, pinIndex)
%   value = readDigitalInput(interfaceHandle, pinIndex)
%   Returns 1 (HIGH) or 0 (LOW) from the specified pinIndex.
%   Throws an error if the Phidget read fails.

    % Validate inputs
    if nargin < 2
        error('Two arguments required: interfaceHandle and pinIndex.');
    end

    % Create pointer to hold input value
    valPtr = libpointer('int32Ptr', 0);

    % Attempt to read digital input
    result = calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', interfaceHandle, pinIndex, valPtr);

    % Check result
    if result ~= 0
        error('Failed to read input %d (Phidget error code: %d)', pinIndex, result);
    end

    % Return value
    value = valPtr.Value;
end