function [ T_d_avg ] = Temp_hSCH_avg( T )

% Calculates the average values given a day/night schedule to be input into
% eQuest. There are 24 values for 0-23 hours.

day_i = 7;
day_o = 23;


k=1;
p=1;
for i=1: length(T)
    
    if i >= day_i && i <= day_o
        
        T_d(k) = T(i); % Daytime temperature
    
    else
       
         T_n(p) = T(i); % Night time temperature

end

end

T_d_avg(1) = nanmean(T_d);
T_d_avg(2) = nanmean(T_n);

end