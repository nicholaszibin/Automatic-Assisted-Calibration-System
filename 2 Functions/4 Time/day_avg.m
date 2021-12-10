function [ xavg xstd ] = day_avg( x )
% This function will take the average of daily data

j=1; % To store the new average value

for i=1:96:length(x)-95
   
    xavg(j) = mean(x(i:i+95));
    xstd(j) = std(x(i:i+95));
  
    j=j+1;
    
end

end

