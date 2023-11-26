# IMU Simulation and Complementary Filtering in MATLAB

## Overview

This MATLAB project simulates an Inertial Measurement Unit (IMU) with added noise and implements complementary filtering with varying gains to evaluate its effectiveness in sensor fusion. The goal is to showcase how different gain values impact the accuracy of orientation estimation using complementary filtering.

## Requirements

- MATLAB (R2019a or later recommended)

## Getting Started

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/IMU-Complementary-Filtering.git
    cd IMU-Complementary-Filtering
    ```

2. Open MATLAB and navigate to the project directory.

3. Open the main script file:

    ```matlab
    IMU_gyro_acc.m
    ```

4. Run the script to execute the simulation.

## Project Structure

- `IMU_gyro_acc.m`: Main script to run the IMU simulation and complementary filtering.
- `results/`: Directory to store simulation results.

## Configuration

Adjust the parameters in the `runSimulation.m` script to customize the simulation:

```matlab
% IMU noise parameters
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
