function digitalin(n)

loadphidget21;
 
handle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetInterfaceKit_create', handle);
calllib('phidget21', 'CPhidget_open', handle, -1);

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0
    disp('Opened InterfaceKit')

    % setup a timer to delay the reads 0.3 seconds
    t = timer('TimerFcn','disp(''Getting data...'')', 'StartDelay', 1);
		start(t);
        wait(t);
		dataptr = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 0, dataptr);
        disp(sprintf('Input 0 = %i',get(dataptr,'Value')));

        dataptr1 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 1, dataptr1);
        disp(sprintf('Input 1 = %i',get(dataptr1,'Value')));
        
        dataptr2 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 2, dataptr2);
        disp(sprintf('Input 2 = %i',get(dataptr2,'Value')));
        
        dataptr3 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 3, dataptr3);
        disp(sprintf('Input 3 = %i',get(dataptr3,'Value')));
        
        dataptr4 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 4, dataptr4);
        disp(sprintf('Input 4 = %i',get(dataptr4,'Value')));
        
        dataptr5 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 5, dataptr5);
        disp(sprintf('Input 5 = %i',get(dataptr5,'Value')));
        
        dataptr6 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 6, dataptr6);
        disp(sprintf('Input 6 = %i',get(dataptr6,'Value')));
        
        dataptr7 = libpointer('int32Ptr',0);
		calllib('phidget21', 'CPhidgetInterfaceKit_getInputState', handle, 7, dataptr7);
        disp(sprintf('Input 7 = %i',get(dataptr7,'Value')));
else
    disp('Could not open InterfaceKit')
end

% clean up
calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);

%unloading the library too quickly causes issues.
%unloadlibrary phidget21;

