close all; clear; clc;

%% Simulation Constants
probFA = 0.01;

n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snrs = linspace(-20, 0, 128);
iters = 16384;

%% Simulation
detector = @(s, l, n, k) UnknownNoiseEqual(s, l, n) / UnknownSignalEqual(s, l, n, k);

result = PDvsSNR(n, l, k, probFA, snrs, iters, detector, true);
writematrix(result, "Data/PDvsSNR/Unknown/Unknown but Equal Variance.csv");

plot(result(1, :), result(2, :))
