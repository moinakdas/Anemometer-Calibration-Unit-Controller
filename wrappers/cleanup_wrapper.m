function cleanup_wrapper(yawConn,pitchConn,gateConn,interfaceConn,yawHandle,pitchHandle,gateHandle,interfaceHandle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if yawConn
        cleanup(yawHandle);
        disp("Yaw motor disengagement SUCCESS!");
    end
    if pitchConn
        cleanup(pitchHandle);
        disp("Pitch motor disengagement SUCCESS!");
    end
    if gateConn
        cleanup(gateHandle);
        disp("Gate motor disengagement SUCCESS!");
    end
    if interfaceConn
        cleanupInterface(interfaceHandle);
        disp("Interface disengagement SUCCESS!");
    end
end