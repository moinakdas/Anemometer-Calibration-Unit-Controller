function velocity = voltToVel(voltage, offset)

    if nargin < 2
        offset = 0;
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
    
    % Convert voltage (mmHg) to Pascals
    pasc = (voltage - offset) * 133.322;

    % === Step 1: Fit dynamic pressure as a function of static pressure ===
    coeffs_pd_vs_ps = polyfit(p_static, p_dynamic, 1);  % linear fit: q = a*p_static + b
    dynamic_from_static = @(ps) polyval(coeffs_pd_vs_ps, ps);
    
    % === Step 2: Estimate dynamic pressure using the fit ===
    p_dynamic_est = dynamic_from_static(pasc);  % get dynamic pressure given static (in Pascals)
    
    % === Step 3: Calculate velocity from dynamic pressure ===
    rho = 1.225;  % Air density in kg/m^3
    p_dynamic_est = max(0, p_dynamic_est);
    velocity = sqrt(2 * p_dynamic_est / rho);  % Velocity in m/s

end