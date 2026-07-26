close all; clear; clc;

%% Simulation Constants
probFA = 0.01;

n = 64; % Number of samples
l = 16; % Array elements
k = 8; % Dimension of subspace

snrs = linspace(-20, 0, 128);
iters = 16384; % Number of MC iterations to run

niterMax = 500; % Maximum number of SSVWW iterations
epsilon = 1e-6; % SSVWW convergence epsilon

%% Simulation
detector = @(s, l, n, k) UnknownNoise(s, l, n) / UnknownSignal(s, l, n, k, niterMax, epsilon);
diversityDetector = @(s, l, n, k) detector(Diversity(s, l), l, n, k);

resultCorrect = PDvsSNR(n, l, k, probFA, snrs, iters, detector, false);
writematrix(resultCorrect, "Data/PDvsSNR/Unknown/Unknown Variance.csv");

resultWrong = PDvsSNR(n, l, k, probFA, snrs, iters, detector, true);
writematrix(resultWrong, "Data/PDvsSNR/Unknown/Wrong/Unknown Variance.csv");

resultDiversity = PDvsSNR(n, l, k, probFA, snrs, iters, diversityDetector, false);
writematrix(resultDiversity, "Data/PDvsSNR/Unknown/Diversity/Unknown Variance.csv");

resultWrongDiversity = PDvsSNR(n, l, k, probFA, snrs, iters, diversityDetector, true);
writematrix(resultWrongDiversity, "Data/PDvsSNR/Unknown/Diversity/Wrong/Unknown Variance.csv");

%% Plotting

% Just plot the results after completion as a quick sanity-check
plot(resultCorrect(1, :), resultCorrect(2, :), "DisplayName", "Correct Model");
hold on
plot(resultWrong(1, :), resultWrong(2, :), "DisplayName", "Wrong Model");
plot(resultDiversity(1, :), resultDiversity(2, :), "DisplayName", "Diversity");
plot(resultWrongDiversity(1, :), resultWrongDiversity(2, :), "DisplayName", "Diversity; Wrong Model");

legend();
