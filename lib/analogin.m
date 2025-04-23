%analogin.m - Outputs the sensor value of specified input
function sensorvalue = analogin(n)

loadphidget21;
 
phid = libpointer('int32Ptr');
calllib('phidget21', 'CPhidgetInterfaceKit_create', phid);
calllib('phidget21', 'CPhidget_open', phid, -1);
 
if calllib('phidget21', 'CPhidget_waitForAttachment', phid, 500) == 0
    dataptr = libpointer('int32Ptr', 0);
    if calllib('phidget21', 'CPhidgetInterfaceKit_getSensorValue', phid, n, dataptr) == 0
        sensorvalue = dataptr.Value;
    else
        % clean up
        calllib('phidget21', 'CPhidget_close', phid);
        calllib('phidget21', 'CPhidget_delete', phid);
        error('Error getting sensor data..');
    end
else
    % clean up
    calllib('phidget21', 'CPhidget_close', phid);
    calllib('phidget21', 'CPhidget_delete', phid);
    error('Could not open InterfaceKit')
end
 
% clean up
calllib('phidget21', 'CPhidget_close', phid);
calllib('phidget21', 'CPhidget_delete', phid);
