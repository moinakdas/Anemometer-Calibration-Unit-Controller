function gatePos = setVelocity(vel, gateHandle, daqHandle, gateZeroStep)
    fprintf('\n');
    drawnow;
    vel = vel + 3;
    % === Handle Extremes ===
    if vel >= 31
        fprintf('WARNING: Velocity Clamped at 28m/s\n');
        drawnow;
        return;
    elseif vel == 0
        moveto(gateHandle,gateZeroStep - 19000);
        fprintf('Velocity reached 0m/s\n');
        drawnow;
        return;
    end

    % === PID Gains ===
    Kp = 150;       % Proportional gain
    Ki = 20;        % Integral gain
    Kd = 20;        % Derivative gain

    TOLERANCE = 0.05;  % Acceptable velocity error
    MAX_ITER = 9;     % Max number of adjustments

    % === PID State Variables ===
    prev_error = 0;
    integral = 0;
    vel_log = [];
    gateStep_log = [];

    % === Initial Gate Position Guess ===
    currentGateStep = vel_toGateStep(vel);
    gatePos = gateZeroStep + currentGateStep;
    moveto(gateHandle, gatePos);
    pause(0.3);

    % === Start PID Loop ===
    for i = 1:MAX_ITER
        % --- Measure Current Velocity ---
        vel_sample = voltToVel(mean(startForeground(daqHandle)), -0.05);

        % --- Compute Error Terms ---
        error = vel - vel_sample;
        integral = integral + error;
        derivative = error - prev_error;

        % --- PID Output ---
        delta_gate = -1 * (Kp * error + Ki * integral + Kd * derivative);
        prev_error = error;

        % --- Update Gate Step ---
        currentGateStep = currentGateStep + round(delta_gate);
        currentGateStep = max(min(currentGateStep, 0), -19000);  % Clamp range
        gatePos = gateZeroStep + currentGateStep;

        % --- Log and Display ---
        vel_log(end+1) = vel_sample;
        gateStep_log(end+1) = currentGateStep;
        fprintf('%d | Current = %.2f | Error = %.2f\n', i, vel_sample - 3, error);

        % --- Check Convergence ---
        if abs(error) < TOLERANCE
            fprintf('Velocity reached %.2fm/s \n', vel_sample - 3);
            break;
        end

        % --- Actuate ---
        moveto(gateHandle, gatePos);
        pause(0.3);
    end
end
