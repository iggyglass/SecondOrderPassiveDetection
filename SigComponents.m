% Simple helper function -- given the data matrix, returns signal separated
% into channel 1 and channel 2
%   x -- "measured" signal
%   n -- number of array elements

function [x1, x2] = SigComponents(x, l)
    x1 = x(1:l, :);
    x2 = x((l + 1):end, :);
end
