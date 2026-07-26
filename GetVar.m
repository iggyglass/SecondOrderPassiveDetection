% Returns the channel variances given whether or not they should be the
% same

function vars = GetVar(same)
    if same
        vars = [1, 1];
    else
        vars = [1, 2];
    end
end
