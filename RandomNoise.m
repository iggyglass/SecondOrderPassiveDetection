% Generates a random noise signal given:
%   n -- number of samples
%   l -- number of elements in array
%   same -- whether the noise variances should be the same

function [x, var] = RandomNoise(n, l, same)
    var = getVar(same);
    R = diag(kron(var, ones(1, l)));
    mu = zeros(1, 2 * l);

    x = (mvnrnd(mu, R, n) + 1i * mvnrnd(mu, R, n))';
end

function var = getVar(same)
    var = [1, 1 * same + 10 * ~same];
end
