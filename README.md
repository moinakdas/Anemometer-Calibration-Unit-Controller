# Anemometer Calibration Unit - MATLAB Control Script

This MATLAB library serves as the controller for the Anemometer Calibration Unit developed under Dr. Spencer Zimmerman at Stony Brook University. The unit is designed to direct airflow via a nozzle at a specified pitch angle, yaw angle, and airflow rate, controllable via the included script. It is designed to work with genuine Phidgets™ stepper motors/controllers, Phidgets™ digital interface, and a DT9834-BNC Data Acquisition Unit. 


## Prerequisites

1. Ensure that the correct version of MATLAB is installed on your system. As of May 2025, this code runs on MATLAB 2023b (64-bit Windows 11).

2. Install the MATLAB Support for MiniGW-w64 C/C++ Compiler from the Add-On Explorer page.

3. Install the MATLAB Data Acquisition Toolbox from the Add-On Explorer page.

4. Install the Data Acquisition Toolbox Support Package for National Instrucments
   
5. Download the *DT-Open Layers for .NET* from Digilent, available [here](https://digilent.com/reference/software/openlayers/start)

6. Download the *Data Translation DAQ Adaptor for MATLAB®* from Digilent, available [here](https://digilent.com/reference/software/start):
  
    This will download a .mltb file, which you need to install using the MATLAB Add-On manager.
   
    After installation, this may be listed as *Data Acquisition Toolbox Support Package for Data Translation Hardware* by Digilent.
   
7. Navigate to ```C:\Users\{username}\AppData\Roaming\MathWorks\MATLAB Add-Ons\Toolboxes\Data Acquisition Toolbox Support Package for Data Translation Hardware\+daq\+dt\+internal'```

   In ```AsyncOLChannel.m``` modify the following lines:

   ```
   Line 1:  classdef AsyncOLChannel < matlabshared.asyncio.internal.Channel
   ```
   ```
   Line 21:  obj@matlabshared.asyncio.internal.Channel(pluginInfo.devicePath, ...
   ```
   ```
   Line 23:  'Options', channelOptions,...
   ```
   ```
   Line 24:  'StreamLimits', streamLimits);
   ```
   ```
   Line 35:  matlabshared.asyncio.internal.DataEventInfo(remainderIn) );
   ```
   ```
   Line 51:  matlabshared.asyncio.internal.DataEventInfo(remainderOut) );
   ```

   In ```ChannelGroupOL.m``` modify the following line:

   ```
   Line 23:  AsynchronousIoChannel = matlabshared.asyncio.internal.Channel.empty();
   ```


## Installation

To install and run this repository locally:

```bash
# Clone the repository
git clone https://github.com/your-username/anemometer-calibration-unit.git
cd anemometer-calibration-unit
```
Then, launch MATLAB and run the main.m script

##

## 📘 API Reference

| Function | Description |
|----------|-------------|
| `cleanup(stepperHandle)` | Disengages and releases a Phidget stepper motor. |
| `cleanupInterface(interfaceHandle)` | Closes and deletes a Phidget InterfaceKit handle. |
| `getMotorPos(motorHandle)` | Returns the current position (steps) of the motor. |
| `initialize(motorID, motorSpeed)` | Initializes a Phidget stepper motor with optional speed. |
| `initializeDAQ()` | Sets up the DT-9834-BNC DAQ session for analog input. |
| `initializeInterface(interfaceID)` | Initializes the Phidget InterfaceKit device. |
| `moveRelative(motorHandle, delta)` | Moves the motor relative to its current position by delta steps. |
| `moveToDegYaw(deg, yawHandle, yawZeroStep)` | Moves the yaw motor to a specified angle from zero. |
| `moveto(stepperHandle, targetPosition)` | Moves the motor to a specific absolute position. |
| `readPin(interfaceHandle, pinIndex)` | Reads the digital input state (HIGH or LOW) of a pin. |
| `setAllNeutral(yawHandle, pitchHandle, gateHandle, yawZeroStep, pitchZeroStep, gateZeroStep)` | Returns all motors to their neutral (resting) position. |
| `setVelocity(vel, gateHandle, daqHandle, gateZeroStep)` | Uses PID to adjust the gate to achieve target airflow velocity. |
| `stepper_control(inputArg1, inputArg2)` | Placeholder control function for future expansion. |
| `vel_toGateStep(desired_velocity)` | Interpolates gate position needed for a desired velocity using calibration data. |
| `voltToVel(voltage, offset)` | Converts sensor voltage (with optional offset) to velocity. |
| `zeroMotor(interfaceHandle, motorHandle, delta_1, delta_2, inputIndex)` | Zeroes a motor using a limit switch and returns its zero position. |
| `cleanup_wrapper(...)` | Safely disengages all devices and prints connection status. |
| `init_wrapper(...)` | Initializes all Phidget motors and DAQ, with connection verification. |
| `runConfigurationSet(configSet, holdTime, ...)` | Executes a sequence of yaw, pitch, and velocity configurations. |
| `zeroMotor_wrapper(...)` | Zeroes all motors (yaw, pitch, gate) using limit switches. |









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
