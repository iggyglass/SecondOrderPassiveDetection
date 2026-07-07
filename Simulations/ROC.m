% Runs an ROC (probability of detection vs. probability of false alarm)
% Monte Carlo simulation given:
%   n         -- number of samples
%   l         -- number of elements in array
%   k         -- dimension of signal subspace
%   probFAs   -- the target probabilities of false alarm
%   snr       -- SNR of the signal
%   iters     -- number of Monte Carlo iterations to run
%   detector  -- function to compute detector statistics given (s, l, n, k)
%                where s is the sample covariance matrix
%   sameNoise -- whether the noise variances should be the same

function result = ROC(n, l, k, snr, iters, detector, sameNoise)
    noiseStat = zeros(1, iters);
    sigStat = zeros(1, iters);
    tic

    for i = 1:iters
        noiseStat(i) = computeStatistic(RandomNoise(n, l, sameNoise), detector, l, n, k);
        sigStat(i) = computeStatistic(RandomSig(n, l, k, sameNoise, snr), detector, l, n, k);
    end

    thresh = linspace(min(noiseStat), max(sigStat), 1024);
    probDet = zeros(1, length(thresh));
    probFA = zeros(1, length(thresh));

    for i = 1:length(thresh)
        probDet(i) = sum(sigStat > thresh(i)) / iters;
        probFA(i) = sum(noiseStat > thresh(i)) / iters;
    end

    toc
    result = [probFA; probDet];
end

function stat = computeStatistic(x, detector, l, n, k)
    s = x * x' / n;

    stat = detector(s, l, n, k);
end
