function cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,daqConn, yawHandle,pitchHandle,gateHandle,interfaceHandle)

    if yawConn
        cleanup(yawHandle);
        disp('Yaw motor disengagement SUCCESS!');
    end
    if pitchConn
        cleanup(pitchHandle);
        disp('Pitch motor disengagement SUCCESS!');
    end
    if gateConn
        cleanup(gateHandle);
        disp('Gate motor disengagement SUCCESS!');
    end
    if interfaceConn
        cleanupInterface(interfaceHandle);
        disp('Interface disengagement SUCCESS!');
    end
    if daqConn
        disp("DAQ disengagement SUCCESS!");
    end
end