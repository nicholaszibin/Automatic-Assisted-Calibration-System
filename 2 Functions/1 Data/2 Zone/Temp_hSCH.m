function [ T_h_avg  T_weh_avg] = Temp_hSCH(t,T)

% The program calculates the average for each hour using average zone
% temperatures to be input into the schedule for eQuest

date = datevec(t);

WEH  = weekday (t);

hour = 0:23;

% Holidays
H_start = datenum('23-dec-2013');
H_end   = datenum('6-jan-2014');
    
for k = 1:length(hour)
    
    j=1;
    p=1;
    
    for i = 1:length(t)
        
            % Weekday hours
        if (date(i,4) == hour(k)) && WEH(i) ~= 1 && WEH(i) ~= 7;
            
            T_h{k}(j) = T(i);
            
            j=j+1;
         
            % Weekend hours
        elseif ((date(i,4) == hour(k)) && (WEH(i) == 1 || WEH(i) == 7)) || (t(i) >= H_start && t(i) < H_end)
        
            T_WEH{k}(p) = T(i);
            
            p=p+1;
            
        end
        end
        
    end
    
    
% Now we calculate the average value in each row    
    
for z=1:length(hour)
   
T_h_avg(z)   = nanmedian(T_h{z});
T_weh_avg(z) = nanmedian(T_WEH{z});
    
end

T_h_avg   = T_h_avg';
T_weh_avg = T_weh_avg';

end

