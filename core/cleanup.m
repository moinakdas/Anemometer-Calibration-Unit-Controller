function cleanup(stepperHandle)
    try
        % Disengage motor
        result = calllib('phidget21', 'CPhidgetStepper_setEngaged', stepperHandle, 0, 0);
        if result ~= 0
            disp('Failed to disengage motor');
        end

        % Close and delete stepper handle
        calllib('phidget21', 'CPhidget_close', stepperHandle);
        calllib('phidget21', 'CPhidget_delete', stepperHandle);

        % Clear handle reference
        clear stepperHandle;
        
    catch ME
        disp(['Error in cleanup: ', ME.message]);
    end
end
