% Computes the H1 detector statistic in the case where noise unknown and
% equal and channel is unknown. Note that this detector assumes n <= 2*l-1.
% If this is not the case, we use a sphericity test instead.

function result = UnknownSignalEqual(s, l, ~, k)
    [vecs, vals] = eig(s);
    [vals, inds] = sort(diag(vals)', 'descend');
    vecs = vecs(:, inds);

    var = sum(vals((k + 1):(2 * l))) / (2 * l - k);
    ds = vals(1:k) - var;

    D = diag([ds, zeros(1, 2 * l - length(ds))]);
    R = vecs * D * vecs' + var * eye(2 * l);

    result = det(R);
end
