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

function result = ROC(n, l, k, probFAs, snr, iters, detector, sameNoise)
    detectorStat = zeros(1, iters);
    etas = zeros(1, length(probFAs));
    tic

    for i = 1:length(probFAs)
        for j = 1:iters
            x = RandomNoise(n, l, sameNoise);
            s = x * x' / n;

            detectorStat(i) = real(detector(s, l, n, k));
        end

        etas(i) = ThresholdBisection(detectorStat, probFAs(i), 1 / iters);
    end

    probDet = zeros(1, length(probFAs));

    for i = 1:length(probFAs)
        detections = 0;

        for j = 1:iters
            x = RandomSig(n, l, k, sameNoise, snr);
            s = x * x' / n;

            stat = detector(s, l, n, k);
            detections = detections + (stat > etas(i));
        end

        probDet(i) = detections / iters;
    end

    toc
    result = [probFAs; probDet];
end
