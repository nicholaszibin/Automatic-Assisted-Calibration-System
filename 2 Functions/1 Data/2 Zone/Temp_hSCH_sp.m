function [ T_h_avg  T_weh_avg] = Temp_hSCH_sp(t,T)

% The program calculates the average for each hour using average zone
% temperatures to be input into the schedule for eQuest

date = datevec(t);

WEH  = weekday(t);

day_i = 7;
day_o = 23;

j=1;
p=1;
k=1;
u=1;
    
  for i = 1:length(t)
        
            % Weekday day hours
        if (date(i,4)>= day_i && date(i,4)< day_o) && WEH(i) ~= 1 && WEH(i) ~= 7;
            
            T_h{1}(j) = T(i);
            
            j=j+1;
          
            % Weekday night hours
        elseif (date(i,4)< day_i || date(i,4)>= day_o) && WEH(i) ~= 1 && WEH(i) ~= 7;
         
             T_h{2}(k) = T(i);
            
            k=k+1;
            
            % Weekend day hours
        elseif (WEH(i) == 1 || WEH(i) == 7) && (date(i,4)>= day_i && date(i,4)< day_o)
        
            T_WEH{1}(p) = T(i);
            
            p=p+1;
            
            % Weekend night hours
        elseif (WEH(i) == 1 || WEH(i) == 7) && (date(i,4)< day_i || date(i,4)>= day_o)
        
            T_WEH{2}(u) = T(i);
            
            u=u+1;
            
        end

        
  end
    
T_h_avg{1}   = nanmedian(T_h{1});
T_h_avg{2}   = nanmedian(T_h{2});  
T_weh_avg{1} = nanmedian(T_WEH{1});
T_weh_avg{2} = nanmedian(T_WEH{2});    

    
end

