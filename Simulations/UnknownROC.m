close all; clear; clc;

%% Simulation Constants
probFAs = logspace(-6, 0, 1024);

n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snr = -10; % SNR in dB

iters = 32768;

%% Simulation
detector = @(s, l, n, k) UnknownNoise(s, l, n) / UnknownSignal(s, l, n, k);

result = ROC(n, l, k, probFAs, snr, iters, detector, false);
writematrix(result, "Data/ROC/Unknown/Unknown Variance.csv");

plot(result(1, :), result(2, :))
