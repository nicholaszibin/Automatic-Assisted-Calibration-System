function [rmse_out mean_x1] = RMSE(x1,x2)
%% This function calculates the root mean square error.
% where x1 is the measured data and x2 is the simulated data.

%Initial conidtion
k=1;

for i=1:length(x1)
   
    if ~isnan(x2(i)) && ~isnan(x1(i))
    
    rmse_ini(k) = (x2(i)-x1(i))^2;
    
    x1_r(k) = x1(i);
    
    k = k+1;
    
    end
    
end

rmse_out = sqrt(sum(rmse_ini)/(k-1));

mean_x1 = nanmean(x1_r);


end

