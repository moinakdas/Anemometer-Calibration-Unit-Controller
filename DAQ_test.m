% % Load the DLL (your path is correct)
% dllPath = 'C:\Program Files (x86)\Data Translation\DotNet\OLClassLib\Framework 2.0 Assemblies\OpenLayers.Base.dll';
% NET.addAssembly(dllPath);
% 
% % Get all loaded .NET assemblies
% assemblies = System.AppDomain.CurrentDomain.GetAssemblies();
% 
% % Find the one you just added
% for i = 1:assemblies.Length
%     name = char(assemblies.Get(i).FullName);
%     if contains(name, 'OpenLayers.Base')
%         baseAsm = assemblies.Get(i);
%         break;
%     end
% end
% 
% % Get types/classes from the assembly
% types = baseAsm.GetTypes();
% for i = 1:types.Length
%     disp(char(types(i).FullName))
% end

dllPath = 'C:\Program Files (x86)\Data Translation\DotNet\OLClassLib\Framework 2.0 Assemblies\OpenLayers.Base.dll';
NET.addAssembly(dllPath);

devMgr = OpenLayers.DeviceCollection.DeviceMgr.Get();

deviceNames = devMgr.GetDeviceNames();
disp(['Number of devices found: ', num2str(deviceNames.Length)]);

for i = 0:deviceNames.Length-1
    disp(['Device ', num2str(i), ': ', char(deviceNames.Get(i))]);
end