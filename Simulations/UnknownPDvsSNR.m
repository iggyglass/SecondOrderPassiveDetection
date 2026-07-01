close all; clear; clc;

%% Simulation Constants
probFA = 0.01;

n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snrs = linspace(-20, 0, 128);
iters = 16384;

niterMax = 500;
epsilon = 1e-6;

%% Simulation
detector = @(s, l, n, k) UnknownNoise(s, l, n) / UnknownSignal(s, l, n, k, niterMax, epsilon);

result = PDvsSNR(n, l, k, probFA, snrs, iters, detector, false);
writematrix(result, "Data/PDvsSNR/Unknown/Unknown Variance.csv");

plot(result(1, :), result(2, :))
