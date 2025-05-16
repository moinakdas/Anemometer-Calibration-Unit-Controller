function setAllNeutral(yawHandle,pitchHandle,gateHandle,yawZeroStep,pitchZeroStep,gateZeroStep)
    moveToDegYaw(0,yawHandle,yawZeroStep);
    moveToDegPitch(0,pitchHandle,pitchZeroStep);
    moveto(gateHandle, gateZeroStep - 12000);
end