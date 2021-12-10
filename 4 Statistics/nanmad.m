function [out_mad] = nanmad(in)

% calculates the median value when there were NaN numbers in a matrix
k=1;
for i=1:length(in)
if ~isnan(in(i))
    out(k) = in(i);
    k=k+1;
end
end

out_mad = mad(out,1);

end
