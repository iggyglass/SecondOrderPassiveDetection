% Returns a sample covariance matrix with the off-diagonals zeroed out for
% use in diversity combining given:
%   ss -- the original sample covariance matrix
%   l -- the number of sensor array elements

function s = Diversity(ss, l)
    [s11, s22] = SplitMatrix(ss, l);

    s = blkdiag(s11, s22);
end

function [X11, X22] = SplitMatrix(X, l)
    X11 = X(1:l, 1:l);
    X22 = X((l + 1):(2 * l), (l + 1):(2 * l));
end
