function cleanupInterface(interfaceHandle)
    % Close the device connection
    calllib('phidget21', 'CPhidget_close', interfaceHandle);

    % Delete the interface handle
    calllib('phidget21', 'CPhidget_delete', interfaceHandle);
end