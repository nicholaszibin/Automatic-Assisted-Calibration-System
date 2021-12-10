function [dT_fan_avg dT_fan_std] = dT_fan_BAS( dT_sm, dT_GLC, CW)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimates the average dT_fan when there is no heating or cooling
% based on the dT of glycol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
   CW(1:length(dT_sm)) = 0; 
end

for i=1:length(dT_GLC)
    
   if (abs(dT_GLC(i)) < sqrt(4*(0.3 + 0.005 * 35)^2)) && CW(i) == 0
       
       dT_fan(i) = dT_sm(i);
   else 
       dT_fan(i) = NaN;
   
   end
   
   
end

dT_fan_avg = nanmedian(dT_fan);
dT_fan_std = nanmad(dT_fan);
end

