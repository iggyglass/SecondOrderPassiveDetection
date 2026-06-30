% Computes the H0 detector statistic in the case where noise is equal
% but unknown between both channels

function result = UnknownNoiseEqual(s, l, ~)
    var = trace(s) / (2 * l);

    % return det(R)
    result = var^(2 * l);
end
