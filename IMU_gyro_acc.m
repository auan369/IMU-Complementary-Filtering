load y120p60r30.mat motion fs
accNED = motion.Acceleration;
angVelNED = motion.AngularVelocity;
orientationNED = motion.Orientation;

numSamples = size(motion.Orientation,1);
t = (0:(numSamples-1)).'/fs;

IMU = imuSensor('accel-gyro','SampleRate',fs);

% aFilter = imufilter('SampleRate',fs);
% 
% orientation = zeros(numSamples,1,'quaternion');
% for i = 1:numSamples
% 
%     [accelBody,gyroBody] = IMU(accNED(i,:),angVelNED(i,:),orientationNED(i,:));
% 
%     orientation(i) = aFilter(accelBody,gyroBody);
% 
% end
% release(aFilter)
% 
% 
% figure(1)
% plot(t,eulerd(orientation,'ZYX','frame'))
% xlabel('Time (s)')
% ylabel('Rotation (degrees)')
% title('Orientation Estimation -- Ideal IMU Data, Default IMU Filter')
% legend('Z-axis','Y-axis','X-axis')



fuse = complementaryFilter('SampleRate', fs,'HasMagnetometer',false, 'AccelerometerGain', 0);
[accelReadings,gyroReadings] = IMU(accNED,angVelNED,orientationNED);


q = fuse(accelReadings, gyroReadings);
figure(1)
plot(t,eulerd(q,'ZYX','frame'));
title('Ideal Orientation');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
ylabel('Degrees');



IMU.Accelerometer = accelparams( ...
    'MeasurementRange',19.62, ...
    'Resolution',0.0059875, ...
    'ConstantBias',0.4905, ...
    'AxesMisalignment',2, ...
    'NoiseDensity',0.0003924, ...
    'BiasInstability',0, ...
    'TemperatureBias', [0.34335 0.34335 0.5886], ...
    'TemperatureScaleFactor',0.02);
IMU.Gyroscope = gyroparams( ...
    'MeasurementRange',4.3633, ...
    'Resolution',0.00013323, ...
    'AxesMisalignment',2, ...
    'NoiseDensity',8.7266e-06, ...
    'TemperatureBias',0.34907, ...
    'TemperatureScaleFactor',0.02, ...
    'AccelerationBias',0.00017809, ...
    'ConstantBias',[0.01,0.05,0]);

% orientationDefault = zeros(numSamples,1,'quaternion');
% for i = 1:numSamples
% 
%     [accelBody,gyroBody] = IMU(accNED(i,:),angVelNED(i,:),orientationNED(i,:));
% 
%     orientationDefault(i) = aFilter(accelBody,gyroBody);
% 
% end
% release(aFilter)
% 
% figure(2)
% plot(t,eulerd(orientationDefault,'ZYX','frame'))
% xlabel('Time (s)')
% ylabel('Rotation (degrees)')
% title('Orientation Estimation -- Realistic IMU Data, Default IMU Filter')
% legend('Z-axis','Y-axis','X-axis')


%new filter


[accelReadings,gyroReadings] = IMU(accNED,angVelNED,orientationNED);


%Fs  = IMU(accNED,angVelNED,orientationNED);  % Hz
fuse = complementaryFilter('SampleRate', fs,'HasMagnetometer',false, 'AccelerometerGain', 0.00);

q = fuse(accelReadings, gyroReadings);
figure(2)
plot(t,eulerd(q,'ZYX','frame'));
title('Orientation Estimate Complementary Filter: Gain 0.00');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
ylabel('Degrees');


fuse = complementaryFilter('SampleRate', fs,'HasMagnetometer',false, 'AccelerometerGain', 0.01);

q = fuse(accelReadings, gyroReadings);
figure(3)
plot(t,eulerd(q,'ZYX','frame'));
title('Orientation Estimate Complementary Filter: Gain 0.01');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
ylabel('Degrees');


fuse = complementaryFilter('SampleRate', fs,'HasMagnetometer',false, 'AccelerometerGain', 0.05);

q = fuse(accelReadings, gyroReadings);
figure(4)
plot(t,eulerd(q,'ZYX','frame'));
title('Orientation Estimate Complementary Filter: Gain 0.05');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
ylabel('Degrees');

fuse = complementaryFilter('SampleRate', fs,'HasMagnetometer',false, 'AccelerometerGain', 0.1);

q = fuse(accelReadings, gyroReadings);
figure(5)
plot(t,eulerd(q,'ZYX','frame'));
title('Orientation Estimate Complementary Filter: Gain 0.10');
legend('Z-rotation', 'Y-rotation', 'X-rotation');
ylabel('Degrees');
