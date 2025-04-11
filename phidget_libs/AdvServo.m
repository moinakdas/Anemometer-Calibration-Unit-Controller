function AdvancedServo

loadphidget21;
 
handle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetAdvancedServo_create', handle);
calllib('phidget21', 'CPhidget_open', handle, -1);

valPtr = libpointer('doublePtr', 0);

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0
    disp('Opened Advanced Servo')
    
    t = timer('TimerFcn','disp(''moving servo...'')', 'StartDelay', 1.0);
    n=0;
    posn=0;
    
    start(t);
    wait(t);
    
    calllib('phidget21', 'CPhidgetAdvancedServo_getVelocityMax', handle, 0, valPtr);
    maxVelocity = get(valPtr, 'Value');
    
    calllib('phidget21', 'CPhidgetAdvancedServo_getAccelerationMax', handle, 0, valPtr);
    maxAccel = get(valPtr, 'Value');
    
    calllib('phidget21', 'CPhidgetAdvancedServo_getPositionMax', handle, 0, valPtr);
    maxPosn = valPtr.Value;
    
    calllib('phidget21', 'CPhidgetAdvancedServo_setAcceleration', handle, 0, maxAccel);
    calllib('phidget21', 'CPhidgetAdvancedServo_setVelocityLimit', handle, 0, maxVelocity);
    
    calllib('phidget21', 'CPhidgetAdvancedServo_setEngaged', handle, 0, 1);
    
    while n<4
        start(t);
        wait(t);
        calllib('phidget21', 'CPhidgetAdvancedServo_setPosition', handle, 0, posn);
        n=n+1;
        if posn == 0
            posn = maxPosn;
        else
            posn = 0;
        end
    end
    
    calllib('phidget21', 'CPhidgetAdvancedServo_setPosition', handle, 0, 0);
    calllib('phidget21', 'CPhidgetAdvancedServo_setEngaged', handle, 0, 0);
else
    disp('Could not open advanced servo')
end

calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);