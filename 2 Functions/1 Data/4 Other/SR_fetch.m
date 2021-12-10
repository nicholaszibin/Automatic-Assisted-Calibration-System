function [ meas_data date_new] = SR_fetch(filename,in_date,out_date)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and calculates the average 
% temperature on a 15minute basis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(filename);

date = data_final(:,1) + data_final(:,2);

%% now we give the end dates of the data

% Converts the dates into number form
    in_datenum  = datenum(in_date,'dd/mm/yyyy HH:MM:SS PM');
    out_datenum = datenum(out_date,'dd/mm/yyyy HH:MM:SS PM');

% Find the starting and end row numbers
    start_row = find(date == in_datenum,1);
    end_row   = find(date == out_datenum,1); 

% Combines the date and time into number then to string type     
    date_new = date(start_row:end_row);

% Outputs measured data point
    meas_data = data_final(start_row:end_row,3);
    
end