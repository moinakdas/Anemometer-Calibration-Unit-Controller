function moveToDegPitch(deg,pitchHandle,pitchZeroStep)
    neutralStep = pitchZeroStep - 30000; % step when yaw motor is at neutral position

    finalStep = neutralStep + deg * (320000/360);
    if finalStep > 30000
        fprintf("WARNING: Pitch Angle Clamped at 33.75 deg\n");
        drawnow;
    elseif finalStep < -30000
        fprintf("WARNING: Pitch Angle Clamped at 33.75 deg\n");
        drawnow;
    end
    finalStep = max(min(finalStep, 39000), -39000);
    moveto(pitchHandle,finalStep)
end