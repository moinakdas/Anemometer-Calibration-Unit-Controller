function runConfigurationSet(configSet, configHoldTime,yawHandle,pitchHandle,gateHandle,yawZeroStep,pitchZeroStep,daqHandle,gateZeroStep)
    % Check inputs
    if size(configSet, 2) ~= 3
        fprintf('configSet must be a n-by-3 matrix. Found size: %dx%d\n', size(configSet,1), size(configSet,2));
        drawnow;
        return;
    end

    % Run configSet
    for i = 1:size(configSet,1)
        fprintf('\n[CONFIG #%d] =======================\n',i);
        drawnow;

        moveToDegYaw(configSet(i,1),yawHandle,yawZeroStep);
        fprintf('Yaw motor reached %d deg\n',configSet(i,1));
        drawnow;

        moveToDegPitch(configSet(i,2),pitchHandle,pitchZeroStep);
        fprintf('Pitch motor reached %d deg\n',configSet(i,2));
        drawnow;
        
        fprintf('Target Velocity: %d',configSet(i,3));
        setVelocity(configSet(i,3),gateHandle,daqHandle,gateZeroStep);
        fprintf('[CONFIG #%d COMPLETE] Holding for %d seconds...\n',i,configHoldTime);
        drawnow;
        pause(configHoldTime);
    end

    %Confirm configuration set closed
    fprintf('\n ============ [ALL CONFIGS COMPLETE] ============\n');
    drawnow;
end