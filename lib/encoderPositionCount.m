function encoderPositionCount()

loadphidget21;
 
handle = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetEncoder_create', handle);
calllib('phidget21', 'CPhidget_open', handle, -1);

if calllib('phidget21', 'CPhidget_waitForAttachment', handle, 2500) == 0
    disp('Opened Encoder')
	
    %dataptr is a ptr where the polling function will store the position value
	dataptr = libpointer('int32Ptr',0);
	
	%handle is the handle ptr that is create when you create the encoder object
	%0 is specifying encoder index 0 (the first encoder input) in this case
	%passing the dataptr pointer to the function which will receive the position value
	calllib('phidget21', 'CPhidgetEncoder_getPosition', handle, 0, dataptr);
	
	%The value returned by getPosition is in encoder pulses.  There are 4 pulses per encoder count, so you need to divide the value by 4.
	countValue = get(dataptr, 'Value') / 4;
	
else
    disp('Could not open Encoder')
end

% clean up
calllib('phidget21', 'CPhidget_close', handle);
calllib('phidget21', 'CPhidget_delete', handle);