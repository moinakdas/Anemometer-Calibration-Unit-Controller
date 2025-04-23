function digitalout(n)

loadphidget21;
 
handle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetInterfaceKit_create', handle);
calllib('phidget21', 'CPhidget_open', handle, -1);

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0
    disp('Opened InterfaceKit')

    % setup a timer to delay the reads 0.3 seconds
    t = timer('TimerFcn','disp(''Getting data...'')', 'StartDelay', 1);
	
	if calllib('phidget21', 'CPhidgetInterfaceKit_setOutputState', handle, 0, 1) == 0
		start(t);
        wait(t);
		dataptr = libpointer('int32Ptr',0);
		if calllib('phidget21', 'CPhidgetInterfaceKit_getOutputState', handle, 0, dataptr) == 0
			disp(sprintf('Relay 0 value set to %i', get(dataptr, 'Value')));
		end
	end
	
	start(t);
    wait(t);
	
	if calllib('phidget21', 'CPhidgetInterfaceKit_setOutputState', handle, 0, 0) == 0
		start(t);
        wait(t);
		dataptr = libpointer('int32Ptr',0);
		if calllib('phidget21', 'CPhidgetInterfaceKit_getOutputState', handle, 0, dataptr) == 0
			disp(sprintf('Relay 0 value set to %i', get(dataptr, 'Value')));
		end
	end

else
    disp('Could not open InterfaceKit')
end

% clean up
calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);

%unloading the library too quickly causes issues.
%unloadlibrary phidget21;

