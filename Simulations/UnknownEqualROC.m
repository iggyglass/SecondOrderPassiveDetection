close all; clear; clc;

%% Simulation Constants
probFAs = logspace(-6, 0, 1024);

n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snr = -10; % SNR in dB

iters = 1000;

%% Simulation
detector = @(s, l, n, k) UnknownNoiseEqual(s, l, n) / UnknownSignalEqual(s, l, n, k);

result = ROC(n, l, k, probFAs, snr, iters, detector, true);
writematrix(result, "Data/ROC/Unknown/Unknown but Equal Variance.csv");

plot(result(1, :), result(2, :))
