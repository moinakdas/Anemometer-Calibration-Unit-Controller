function gate_required = vel_toGateStep(desired_velocity)
    
    if desired_velocity == 0
        gate_required = 0;
        return
    end

    % === Load Data from CSV ===
    currentFunctionPath = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(currentFunctionPath);
    dataFile = fullfile(projectRoot, 'data', 'PressureGateData.csv');
    data = readmatrix(dataFile);
    
    % Extract columns
    p_dynamic = data(:, 1);  % Dynamic pressure in Pascals
    p_static  = data(:, 2);  % Static pressure in Pascals
    gate_pos  = data(:, 3);  % Gate position (steps w.r.t gate zero pos)
    
    % === Step 1: Fit dynamic pressure as a function of static pressure ===
    coeffs_pd_vs_ps = polyfit(p_static, p_dynamic, 1);  % linear fit: q = a*p_static + b
    dynamic_from_static = @(ps) polyval(coeffs_pd_vs_ps, ps);
    
    % === Step 2: Estimate dynamic pressure using the fit ===
    p_dynamic_est = dynamic_from_static(p_static);  % get dynamic pressure given static
    
    % === Step 3: Calculate velocity from dynamic pressure ===
    rho = 1.225;  % Air density in kg/m^3
    velocity = sqrt(2 * p_dynamic_est / rho);  % Velocity in m/s
    
    % === Step 4: Interpolation function: velocity -> gate position ===
    get_gate_position = @(v) interp1(velocity, gate_pos, v, 'linear', 'extrap');
        
    % Get gate position that gives this velocity
    gate_required = round(get_gate_position(desired_velocity));

    %Clamp output to gate limits
    gate_required = -1 * min(max(gate_required, 0), 19000);

end