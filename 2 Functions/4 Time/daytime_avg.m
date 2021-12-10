function [ tavg ] = daytime_avg( t )
% This function matches a time for the daily averaged values.

j=1; % Placeholder for new average time
for i=1:96:length(t)-95
    
    tavg(j)=t(i);
    j=j+1;
    
end
end

