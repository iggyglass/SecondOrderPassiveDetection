% Runs a probability of detection vs SNR Monte Carlo simulation given
%   n         -- number of samples
%   l         -- number of elements in array
%   k         -- dimension of signal subspace
%   probFA    -- the target probability of false alarm
%   snrs      -- a row vector of SNRs to perform analysis on
%   iters     -- number of Monte Carlo iterations to run
%   detector  -- function to compute detector statistics given (s, l, n, k)
%                where s is the sample covariance matrix
%   sameNoise -- whether the noise variances should be the same

function result = PDvsSNR(n, l, k, probFA, snrs, iters, detector, sameNoise)
    detectorStat = zeros(1, iters);
    tic

    for i = 1:iters
        x = RandomNoise(n, l, sameNoise);
        s = x * x' / n;

        detectorStat(i) = real(detector(s, l, n, k));
    end

    eta = ThresholdBisection(detectorStat, probFA, 2 / iters); % 1e-9
    probDet = zeros(1, length(snrs));

    for i = 1:length(snrs)
        detections = 0;

        for j = 1:iters
            x = RandomSig(n, l, k, sameNoise, snrs(i));
            s = x * x' / n;

            stat = detector(s, l, n, k);
            detections = detections + (stat > eta);
        end

        probDet(i) = detections / iters;
    end

    toc
    result = [snrs; probDet];
end
