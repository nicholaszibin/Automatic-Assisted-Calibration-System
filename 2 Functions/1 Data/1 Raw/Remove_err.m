function [ input] = Remove_err( input,low,high )
% Removes error data points above a max and below a mean value.

for i=1:length(input)
if input(i) > high || input(i) < low
    
    input(i) = NaN;

end
end

end
