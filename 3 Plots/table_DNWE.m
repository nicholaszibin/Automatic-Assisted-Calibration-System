function [var_Davg var_Dstd var_Navg var_Nstd var_WEavg var_WEstd] = table_DNWE( var,t )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seperates a Toa plot into day/night and weekday/weekend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

day_start = 6/24;
day_end   = 19/24;

k=1;
h=1;
j=1;
for i=1:length(t)

    % If it is night time
    if t(i)-floor(t(i)) > day_end || t(i)-floor(t(i)) < day_start
    
        var_N(k) = var(i);
        k=k+1;
    
    % If it is a weekday
    % Sunday = day 1, Saturday = day 7
    elseif weekday(t(i)) == 7 || weekday(t(i)) == 1
        
        var_WE(h) = var(i);
        h=h+1;
    
    % Plotting Day values    
    else
        
        var_D(j) = var(i);
        j=j+1;
        
end
end

var_Davg  = nanmean(var_D);
var_Dstd = nanstd(var_D);

var_Navg  = nanmean(var_N);
var_Nstd = nanstd(var_N);

var_WEavg  = nanmean(var_WE);
var_WEstd = nanstd(var_WE);

end

