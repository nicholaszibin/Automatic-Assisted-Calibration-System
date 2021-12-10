function [ tavg ] = time_avg( t )
% This function matches a time for the hourly averaged values.
% The functions works a backwards function meaning that
% for 2h0min-2h45min goes to 2h.

j=1; % Placeholder for new average time
for i=1:4:length(t)
    
    tavg(j)=t(i);
    j=j+1;
end
end

