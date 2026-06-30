% Computes the H0 detector statistic in the case where noise is unequal
% and unknown between channels

function result = UnknownNoise(s, l, ~)
    [s1, s2] = SplitMatrix(s, l);

    var1 = trace(s1 / l);
    var2 = trace(s2 / l);

    % return det(R)
    result = (var1 * var2) ^ l;
end

function [X11, X22] = SplitMatrix(X, l)
    X11 = X(1:l, 1:l);
    X22 = X((l + 1):(2 * l), (l + 1):(2 * l));
end

