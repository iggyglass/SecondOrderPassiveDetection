% Computes the detector threshold for given probability of false alarm,
% statistic under the null hypothesis, and epsilon by using a binary search

function eta = ThresholdBisection(H0stat, probFA, epsilon)
    a = min(H0stat);
    b = max(H0stat);

    bis = (a + b) / 2;
    err = calcError(H0stat, probFA, bis);

    % because this is a binary search, the maximum number of iterations we
    % will ever need is log2(N).
    niterMax = ceil(abs(log2(epsilon))); 

    for i = 1:niterMax
        if (~((err > epsilon) && (abs(a - b) > epsilon * 100)))
            break
        end

        currBis = sum(H0stat > bis) / length(H0stat);

        if currBis > probFA
            a = bis;
        else
            b = bis;
        end

        bis = (a + b) / 2;
        err = calcError(H0stat, probFA, bis);
    end

    eta = bis;
end

function err = calcError(H0stat, probFA, bis)
    err = abs(sum(H0stat > bis) / length(H0stat) - probFA);
end
