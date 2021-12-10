function [mbe_out] = MBE(x1,x2)
%% This function calculates the mean bias error.
% where x1 is the measured data and x2 is the simulated data.

%Initial conidtion
k=1;

for i=1:length(x1)
   
    if ~isnan(x2(i)) && ~isnan(x1(i))
    
    mbe_ini(k)    = (x2(i)-x1(i));
    
    x_meas(k) = x1(i);
    
    k = k+1;
    
    end
    
end

mbe_out = sum(mbe_ini)/sum(x_meas);


end

