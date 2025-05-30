# Anemometer Calibration Unit - MATLAB Control Script

This MATLAB library serves as the controller for the Anemometer Calibration Unit developed under Dr. Spencer Zimmerman at Stony Brook University. The unit is designed to direct airflow via a nozzle at a specified pitch angle, yaw angle, and airflow rate, controllable via the included script. It is designed to work with genuine Phidgets™ stepper motors/controllers, Phidgets™ digital interface, and a DT9834-BNC Data Acquisition Unit. 


## How It Works

### Initialization
- All required motor and DAQ handles are created using `init_wrapper.m`.
- Connections are verified and printed to the console.

### Zeroing
- Each motor is zeroed using limit switches via `zeroMotor_wrapper.m`.
- Zero positions are stored for reference during operation.

### Configuration Execution
- `runConfigurationSet.m` iterates over a matrix of [Yaw, Pitch, Velocity] configurations.
- Motors move to specified orientations and airflow velocity is achieved using PID-controlled gate positioning.

### Cleanup
- All motors are disengaged and handles released using `cleanup_wrapper.m`, even in the case of failure.

---

## Dependencies

- MATLAB with the Data Acquisition Toolbox
- **Phidget21 library**: Required for interfacing with Phidget devices. This must be installed and included in `/lib`. These files are provided by Phidgets Inc. and were **not authored by the developer of this repository**.

---

## Data File

- `/data/PressureGateData.csv` contains three columns: `Dynamic Pressure`, `Static Pressure`, and `Gate Position` (in steps).
- Used for interpolation-based control in `vel_toGateStep.m` and `voltToVel.m`.

---

## Installation

To install and run this repository locally:

```bash
# Clone the repository
git clone https://github.com/your-username/anemometer-calibration-unit.git
cd anemometer-calibration-unit

# Launch MATLAB and set path
# In MATLAB Command Window:
addpath(genpath(pwd));
savepath;

# Run the main script
main

