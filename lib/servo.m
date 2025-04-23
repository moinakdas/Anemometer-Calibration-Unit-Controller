function servo

loadphidget21;
 
handle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetServo_create', handle);
calllib('phidget21', 'CPhidget_open', handle, -1);

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0
    disp('Opened servo')
    
    % setup a timer to delay the motor 1 second
    t = timer('TimerFcn','disp(''moving servo...'')', 'StartDelay', 1.0);
    n=0;
    posn=0;

    start(t);
    wait(t);
    
    % move it back and forth twice
    while n<4
        start(t);
        wait(t);
        % actually move the motor
        calllib('phidget21', 'CPhidgetServo_setPosition', handle, 0, posn);
        n=n+1;
        if posn == 0
            posn = 180;
        else
            posn = 0;
        end
    end
    
    % stop the servo
    calllib('phidget21', 'CPhidgetServo_setPosition', handle, 0, -23);
else
    disp('Could not open servo')
end

% clean up
calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);

%unloading the library too quickly causes issues.
%unloadlibrary phidget21;
