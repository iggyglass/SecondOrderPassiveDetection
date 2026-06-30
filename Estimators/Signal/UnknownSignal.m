% Computes the H1 detector statistic in the case where noise unknown and
% unequal and channel is unknown. Largely stolen from Ignacio's SSVWW code.

function result = UnknownSignal(S, l, ~, k, niterMax, epsilon)
    [S11, S22] = SplitMatrix(S, l);

    R = [S11, zeros(l, l); zeros(l, l), S22];

    for i = 1:niterMax
        Rni = sqrtm(inv(R));
        A = Rni * S * Rni;

        [U, D, ~] = svd(A);
        D = diag(D);

        W = sqrt(diag(D(1:k) - ones(k, 1)));
        H = sqrtm(R) * U(:, 1:k) * W;

        B = S - H * H';
        [var11, var22] = SplitMatrix(B, l);

        var11 = trace(var11) / l * eye(l);
        var22 = trace(var22) / l * eye(l);
        R = [var11, zeros(l, l); zeros(l, l), var22];

        Rest = R + H * H';

        if abs(real(trace(Rest \ S)) - 2 * l) < epsilon
            break;
        end
    end

    result = det(R + H * H');
end

function [X11, X22] = SplitMatrix(X, l)
    X11 = X(1:l, 1:l);
    X22 = X((l + 1):(2 * l), (l + 1):(2 * l));
end
