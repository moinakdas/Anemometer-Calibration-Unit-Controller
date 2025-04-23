function interfaceHandle = initializeInterface(interfaceID)
    if nargin < 1  % If 'deviceID' is not provided
        deviceID = -1;  % Default value to open any device
    end

    % Create a handle for the InterfaceKit
    interfaceHandle = libpointer('int32Ptr');
    calllib('phidget21', 'CPhidgetInterfaceKit_create', interfaceHandle);

    % Open the InterfaceKit
    calllib('phidget21', 'CPhidget_open', interfaceHandle, interfaceID);

    % Wait for the device to be attached
    if calllib('phidget21', 'CPhidget_waitForAttachment', interfaceHandle, 2500) == 0
    else
        error('Could Not Open InterfaceKit');
    end
end