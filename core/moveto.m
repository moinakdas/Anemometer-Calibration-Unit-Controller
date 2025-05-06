function moveto(stepperHandle, targetPosition)

    valPtr = libpointer('int64Ptr', 0);
    calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', stepperHandle, 0, valPtr);
    currPosition = get(valPtr, 'Value');

    calllib('phidget21', 'CPhidgetStepper_setTargetPosition', stepperHandle, 0, targetPosition);

    % Wait for the motor to reach the target position
    while currPosition ~= targetPosition
        calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', stepperHandle, 0, valPtr);
        currPosition = get(valPtr, 'Value');
    end

end