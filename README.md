# Anemometer Calibration Unit - MATLAB Control System

This MATLAB-based control system manages a custom-built anemometer calibration unit developed under Dr. Spencer Zimmerman at Stony Brook University.
---

## Project Structure
.
├── main.m # Entry point for full system execution
├── core/ # Core low-level motor and DAQ functions
│ ├── cleanup.m
│ ├── cleanupInterface.m
│ ├── getMotorPos.m
│ ├── initialize.m
│ ├── initializeDAQ.m
│ ├── initializeInterface.m
│ ├── moveRelative.m
│ ├── moveToDegYaw.m
│ ├── moveto.m
│ ├── readPin.m
│ ├── setAllNeutral.m
│ ├── setVelocity.m
│ ├── stepper_control.m
│ ├── vel_toGateStep.m
│ ├── voltToVel.m
│ └── zeroMotor.m
├── wrappers/ # High-level workflow control wrappers
│ ├── cleanup_wrapper.m
│ ├── init_wrapper.m
│ ├── runConfigurationSet.m
│ └── zeroMotor_wrapper.m
├── data/ # Sensor calibration data
│ └── PressureGateData.csv
├── lib/ # Phidget-provided MATLAB libraries (external)

---

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

