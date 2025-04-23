function stepper

loadphidget21;
 
stepperHandle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetStepper_create', stepperHandle);
calllib('phidget21', 'CPhidget_open', stepperHandle, -1);

valPtr = libpointer('int64Ptr', 0);

if calllib('phidget21', 'CPhidget_waitForAttachment', stepperHandle, 2500) == 0
    disp('Opened Stepper');

    t = timer('TimerFcn','disp(''waiting...'')', 'StartDelay', 1.0);

    %set parameters for stepper motor in index 0 (velocity, acceleration, current)
    %these values were set basd on some testing based on a 1063 and a stepper motor I had here to test with
    %might need to modify these values for your particular case
    calllib('phidget21', 'CPhidgetStepper_setVelocityLimit', stepperHandle, 0, 6200);
    calllib('phidget21', 'CPhidgetStepper_setAcceleration', stepperHandle, 0, 87543);
    calllib('phidget21', 'CPhidgetStepper_setCurrentLimit', stepperHandle, 0, 0.26);

    %IMPORTANT: If you are using a 1062, delete this line.  This command is only for the 1063 Bipolar stepper controller
    calllib('phidget21', 'CPhidgetStepper_setCurrentPosition', stepperHandle, 0, 0);

    start(t);
    wait(t);

    disp('Engage Motor 0');

    %engage the stepper motor in index 0
    calllib('phidget21', 'CPhidgetStepper_setEngaged', stepperHandle, 0, 1);
    start(t);
    wait(t);

    currPosition=0;
    calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', stepperHandle, 0, valPtr);
    currPosition = get(valPtr, 'Value');

    disp('Move to 20000');

    %set motor to position 1 (20000)
    calllib('phidget21', 'CPhidgetStepper_setTargetPosition', stepperHandle, 0, 20000);

    %wait for motor to arrive
    while currPosition < 20000
        calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', stepperHandle, 0, valPtr);
        currPosition = get(valPtr, 'Value');
    end
    disp('Motor reached target');

    start(t);
    wait(t);

    disp('Move to 0');

    %set motor to position 2 (0)
    calllib('phidget21', 'CPhidgetStepper_setTargetPosition', stepperHandle, 0, 0);

    %wait for motor to arrive
    while currPosition > 0
        calllib('phidget21', 'CPhidgetStepper_getCurrentPosition', stepperHandle, 0, valPtr);
        currPosition = get(valPtr, 'Value');
    end
    disp('Motor reached target');

    disp('Disengage Motor 0');

    %disengage the stepper motor in index 0
    calllib('phidget21', 'CPhidgetStepper_setEngaged', stepperHandle, 0, 0);
    start(t);
    wait(t);
else
    disp('Could Not Open Stepper');
end

disp('Closing Stepper');
% clean up
calllib('phidget21', 'CPhidget_close', stepperHandle);
calllib('phidget21', 'CPhidget_delete', stepperHandle);

disp('Closed Stepper');