function xavg = hour_avg( x )
% This function will take the average of subhourly data

j=1; % To store the new average value

for i=1:4:length(x)-2
    xavg(j) = nanmedian([x(i) x(i+1) x(i+2) x(i+3)]);
    j=j+1;
end


end

