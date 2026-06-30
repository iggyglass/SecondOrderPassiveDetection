close all; clear; clc;

%% Simulation Parameters
n = 64; % Number of samples
l = 16; % Number of elements in sensor array
k = 8; % Dimension of subspace

snr = linspace(-10, 0, 512); % RX signal SNR in dB
varRatio = 2; % Ratio of Ch. 1 variance to Ch. 2 variance

niter = 4096; % Number of simulations to run at each step

%% Approximation under test
function [s1, s2] = approx(x)
    [x1, x2] = SigComponents(x, l);
    
    s1 = trace(x1 * x1') / (n * l);
    s2 = trace(x2 * x2') / (n * l);
end

%% Simulation


%% Plotting
