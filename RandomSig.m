% Generates a random recieved signal given:
%   n -- number of samples
%   l -- number of elements in array
%   k -- dimension of signal subspace
%   same -- whether the noise variances should be the same
%   snr -- the SNR of the recieved data in dB

function [x, var] = RandomSig(n, l, k, same, snr)
    var = getVar(same);
    R = diag(kron(var, ones(1, l)));
    mu = zeros(1, 2 * l);

    sigBasis = dftmtx(l) / sqrt(l);
    sigBasis = sigBasis(:, 1:k);
    H = [sigBasis; sigBasis];

    common = mvnrnd(zeros(1, n), eye(n), k);
    srcPwr = real(10^(snr / 10) * trace(R) / trace(H * H'));
    noise = (mvnrnd(mu, R, n) + 1i * mvnrnd(mu, R, n))' / sqrt(2);

    x = sqrt(srcPwr) * H * common + noise;
end

function var = getVar(same)
    temp = unifrnd(0, 1);

    if same
        var = [temp, temp];
    else
        var = [temp, unifrnd(0, 1)];
    end
end
