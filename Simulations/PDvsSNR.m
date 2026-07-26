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
        
        % Floating point error sometimes creates very small imaginary
        % components in our detector statistic, hence we just take the real
        % part (note that this is also something that Cole does)
        detectorStat(i) = real(detector(s, l, n, k));
    end

    eta = ThresholdBisection(detectorStat, probFA, 1 / iters);
    probDet = zeros(1, length(snrs));

    for i = 1:length(snrs)
        detections = 0;
        snr = snrs(i);

        parfor j = 1:iters
            x = RandomSig(n, l, k, sameNoise, snr);
            s = x * x' / n;

            % MATLAB's linter doesn't realize that `detector` is a function
            % and not an array that we're indexing, as this is impossible
            % to deduce from this file alone given MATLAB's grammar
            stat = real(detector(s, l, n, k));
            detections = detections + (stat > eta);
        end

        probDet(i) = detections / iters;
    end

    toc
    result = [snrs; probDet];
end
