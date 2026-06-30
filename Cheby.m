% Quick Chebyshev inequality on how many Monte Carlo iterations to do:
%   probErr -- Probability that our result differs from the true value by
%              more than c
%   c -- See above

function niter = Cheby(probErr, c)
    % Note that since P_D is supported on [0, 1], its maximum variance is
    % given by the variance of U(0, 1) which is 1/12.

    niter = ceil(1 / (12 * probErr * c^2));
end
