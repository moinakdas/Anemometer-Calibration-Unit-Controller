function cleanup(stepperHandle)
    disp('Disengaging and closing Stepper...');

    % Disengage motor
    calllib('phidget21', 'CPhidgetStepper_setEngaged', stepperHandle, 0, 0);

    % Close and delete stepper handle
    calllib('phidget21', 'CPhidget_close', stepperHandle);
    calllib('phidget21', 'CPhidget_delete', stepperHandle);

    disp('Stepper Closed');
end