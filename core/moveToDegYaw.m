function moveToDegYaw(deg,yawHandle,yawZeroStep)
    neutralStep = yawZeroStep - 40000; % step when yaw motor is at neutral position

    finalStep = neutralStep + deg * (-320000/360);
    if finalStep > 40000
        fprintf("WARNING: Yaw Angle Clamped at 45 deg\n");
        drawnow;
    elseif finalStep < -40000
        fprintf("WARNING: Yaw Angle Clamped at -45 deg\n");
        drawnow;
    end
    finalStep = max(min(finalStep, 39000), -39000);
    moveto(yawHandle,finalStep)
end