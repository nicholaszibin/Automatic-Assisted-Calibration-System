function [ meas_data date_time] = data_fetch (meas_id,in_date,out_date,filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(['all',filename]);

% Find the column representing the measured point
    col = find(strcmp(header,meas_id));

% Converts the dates into number form
    in_datenum  = datenum(in_date);
    
    % We test to see if the remainder is a zero to determine if we the
    % whole date or just a specific hour
    if rem(datenum(out_date),1) == 0
        
        out_datenum = datenum(out_date)+1;
    else
        out_datenum = datenum(out_date);
    end
    
% Find the starting and end row numbers
    start_row = find(data(:,1)+data(:,2) == in_datenum,1);
    end_row   = find(data(:,1)+data(:,2) == out_datenum-15/60/24,1); 

    if isempty(start_row) || isempty(end_row)
        
        error('Error caused by not matching dates. Choose other time');
        
    end
    
% Combines the date and time into number then to string type     
    date_time = data(start_row:end_row,1)+data(start_row:end_row,2);

% Outputs measured data point
    meas_data = data(start_row:end_row,col);
      
end
