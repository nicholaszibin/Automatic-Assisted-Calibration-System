function [ M_h_avg  M_weh_avg] = Mzone_hSCH(t,M)

% The program calculates the average min flow ratio to be input into the schedule for eQuest

M_max = nanmax(M);

date = datevec(t);

WEH  = weekday(t);

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
            
            M_h{k}(j) = M(i) / M_max;
            
            j=j+1;
         
            % Weekend hours
        elseif ((date(i,4) == hour(k)) && (WEH(i) == 1 || WEH(i) == 7)) || (t(i) >= H_start && t(i) < H_end)
        
            M_WEH{k}(p) = M(i) / M_max;
            
            p=p+1;
            
        end
        end
        
    end
    
    
% Now we calculate the average value in each row    
    
for z=1:length(hour)
   
M_h_avg(z)   = nanmedian(M_h{z});
M_weh_avg(z) = nanmedian(M_WEH{z});
    
end

M_h_avg   = M_h_avg';
M_weh_avg = M_weh_avg'; 

end

