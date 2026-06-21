% clc;
% clear;
% close all;
% time=1:650000;
% load('100m.mat');
% ECG =[time' val'];

clc;
clear;
close all;

load('100m.mat');     % val variable

Fs = 360;             % MIT-BIH ECG sampling frequency
N = length(val);
%time = (0:N-1)'/Fs;
time=1:650000;

ecg = val(:);         % column vector

% Desired SNR in dB
SNR_dB = 10;          % change 5, 10, 15, 20 as needed

% Signal power
signal_power = mean(ecg.^2);

% Noise power
noise_power = signal_power / (10^(SNR_dB/10));

% Generate Gaussian noise
noise = sqrt(noise_power) * randn(size(ecg));

% Noisy ECG
ecg_noisy = ecg + noise;

% Store time and noisy ECG
ECG_clean = [time' ecg];
ECG_noisy = [time' ecg_noisy];

% Plot
figure;
plot(time(1:3600), ecg(1:3600));
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Clean ECG Signal');

figure;
plot(time(1:3600), ecg_noisy(1:3600));
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title(['Noisy ECG Signal, SNR = ', num2str(SNR_dB), ' dB']);