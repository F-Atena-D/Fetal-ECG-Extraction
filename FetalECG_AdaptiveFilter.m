
clear variables; clc; 

% Load the mixed maternal and fetal ECG data
load('sub01_snr00dB_l3_c4_fecg1m.mat')
mixed = val(25, :); % Extract the 25th row of the 'val' matrix, which contains the ECG signal
t = 1/128:1/128:2500/128; % Create a time vector (sampling rate is 128 Hz, for a duration of 2500 samples)

% Plot the mixed ECG signal
figure; plot(t, mixed);
xlabel('time (seconds)');
ylabel('ECG (microvolt)');

% Load the maternal ECG data
load('sub01_snr00dB_l3_c4_mecgm.mat')
maternal = val(25,:); % Extract the 25th row of the 'val' matrix, which contains the ECG signal

% Plot the maternal ECG signal
figure; plot(t, maternal);
xlabel('time (seconds)');
ylabel('ECG (microvolt)');

% Adaptive filtering using the Least Mean Squares (LMS) algorithm
h = dsp.LMSFilter(32); % Create an LMS adaptive filter object with 32 filter coefficients
[fetal, e] = filter(h, mixed/max(mixed), maternal/max(maternal)); % Apply the adaptive filter (normalize the signals to prevent numerical issues)

% Plot the fetal ECG signal (output of the adaptive filter)
figure; plot(t, fetal);
xlabel('time (seconds)');
ylabel('ECG (normalized)');

