% Computes the detector threshold for given probability of false alarm,
% statistic under the null hypothesis, and epsilon by using a binary search

function eta = ThresholdBisection(H0stat, probFA, epsilon)
    a = min(H0stat);
    b = max(H0stat);

    bis = (a + b) / 2;
    err = calcError(H0stat, probFA, bis);

    while ((err > epsilon) && (abs(a - b) > epsilon * 100))
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
