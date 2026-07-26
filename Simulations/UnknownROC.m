close all; clear; clc;

%% Simulation Constants
n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snr = -10; % SNR in dB

iters = 16384; % Number of MC iterations to run

niterMax = 500; % Maximum number of SSVWW iterations
epsilon = 1e-6; % SSVWW convergence epsilon

%% Simulation
detector = @(s, l, n, k) UnknownNoise(s, l, n) / UnknownSignal(s, l, n, k, niterMax, epsilon);
diversityDetector = @(s, l, n, k) detector(Diversity(s, l), l, n, k);

resultCorrect = ROC(n, l, k, snr, iters, detector, false);
writematrix(resultCorrect, "Data/ROC/Unknown/Unknown Variance.csv");

resultWrong = ROC(n, l, k, snr, iters, detector, true);
writematrix(resultWrong, "Data/ROC/Unknown/Wrong/Unknown Variance.csv");

resultDiversity = ROC(n, l, k, snr, iters, diversityDetector, false);
writematrix(resultDiversity, "Data/ROC/Unknown/Diversity/Unknown Variance.csv");

resultWrongDiversity = ROC(n, l, k, snr, iters, diversityDetector, true);
writematrix(resultWrongDiversity, "Data/ROC/Unknown/Diversity/Wrong/Unknown Variance.csv");

%% Plotting

% Just plot the results after completion as a quick sanity-check
plot(resultCorrect(1, :), resultCorrect(2, :), "DisplayName", "Correct Model");
hold on
plot(resultWrong(1, :), resultWrong(2, :), "DisplayName", "Wrong Model");
plot(resultDiversity(1, :), resultDiversity(2, :), "DisplayName", "Diversity");
plot(resultWrongDiversity(1, :), resultWrongDiversity(2, :), "DisplayName", "Diversity; Wrong Model");

legend();
