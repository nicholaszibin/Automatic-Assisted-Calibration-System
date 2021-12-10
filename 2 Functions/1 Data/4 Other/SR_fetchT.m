function [ meas_data date_new] = SR_fetchT(filename,in_date,out_date)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and calculates the average 
% temperature on a 15minute basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(filename);

% Time step
dt = 2 * 60; %seconds

d_ini = data_final(1,1);
t_ini = minute(data_final(1,2));
h_ini = floor(data_final(1,2)*24);

d15 = 15;

if t_ini >= 0 && t_ini < d15    
    t15_ini = 0;    
elseif t_ini >= d15 && t_ini < 2*d15    
    t15_ini = d15;    
elseif t_ini >= 2*d15 && t_ini < 3*d15    
    t15_ini = 2*d15;
else    
    t15_ini = 3*d15;    
end

% Now we calculate the average
t15(1) = t15_ini; % multiple of 15

h = 1; % variable for the new 15min average
k = 1; % variable for the varying temp.

T_var(1) = data_final(1,3);

for i = 1:length(data_final)-1
   
 if (minute(data_final(i,2)) - t15(h)) < 15 && (minute(data_final(i+1,2)) - t15(h)) > 0
        
        T_var(k) = data_final(i,3);
        k = k + 1;
        
 elseif (minute(data_final(i,2)) - t15(h)) > 15
        
        T_new(h) = nanmean(T_var);
        t_new(h) = data_final(i,1) + h_ini(h)/24 + t15(h)/24/60;
               
        k = 1;
        h = h + 1;
        
        t15(h)   = t15(h-1) + 15;
        h_ini(h) = h_ini(h-1);
        
        clear T_var;
        
 elseif (minute(data_final(i+1,2)) - t15(h)) < 0
     
        T_new(h) = nanmean(T_var);
        t_new(h) = data_final(i,1) + h_ini(h)/24 + t15(h)/24/60;
               
        k = 1;
        h = h + 1;
        h_ini(h) = h_ini(h-1)+1;
        
        t15(h)   = 0; 
        
        if h_ini(h) == 24    
            h_ini(h) = 0;
        end
        
        clear T_var;
        
 end
 
end

%% now we give the end dates of the data

% Converts the dates into number form
    in_datenum  = datenum(in_date,'dd/mm/yyyy HH:MM PM');
    out_datenum = datenum(out_date,'dd/mm/yyyy HH:MM PM');

% Find the starting and end row numbers
    start_row = find(t_new - in_datenum >= 0,1);
    end_row   = find(t_new - out_datenum >= 0,1); 

% Combines the date and time into number then to string type     
    date_new = t_new(start_row:end_row);

% Outputs measured data point
    meas_data = T_new(start_row:end_row);
    

end