function [ out] = nanlength( in )
% Calculates the length of the array without NaN numbers

k=1;
for i=1:length(in)
    if ~isnan(in(i))
        new(k) = in(i);
        k=k+1;
    end
end

out = length(new);

end

