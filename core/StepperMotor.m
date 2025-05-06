classdef StepperMotor
    properties
        motorType; %Stores either gate, pitch, yaw
        interfaceHandle;
        handle;
        stepMap;
        isZeroed;
    end

    methods
        % Constructor
        function obj = StepperMotor(interfaceHandle, motorType, handle)
            obj.motorType = motorType;
            obj.handle = handle;
            obj.isZeroed = false;
        end
        
        % zero the motors
        function zero()
            if obj.motorType == 'YAW'
                yawZeroStep = zeroMotor(interfaceHandle, yawHandle,2000,-1000,0);
                fprintf("Yaw motor zeroed at %d\n", yawZeroStep);
            elseif obj.motorType == 'PITCH'
                
            elseif obj.motorType == 'GATE'
                gateZeroStep = zeroMotor(interfaceHandle, gateHandle,500,-250,2);
                fprintf("Gate motor zeroed at %d\n", gateZeroStep);
            end
        end

        function moveToStep(step)
            if obj.isZeroed
                if obj.motorType == ""
                safeStep = min(max(step, obj.stepMap('zero')));
            end
        end
    end
end