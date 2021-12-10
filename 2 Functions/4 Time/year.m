function [ min ] = minute( t )
% Calculate the minute given a date in decimal numeral form

min = ceil((t*24-floor(t*24))*60);

    min = min - rem(min,5);

end

