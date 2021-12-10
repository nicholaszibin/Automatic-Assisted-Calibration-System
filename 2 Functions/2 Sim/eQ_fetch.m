function [ meas_data date_time] = eQ_fetch(meas_id,i_date,o_date,filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(filename);

% Find the column representing the measured point
    col = find(strcmp(header,meas_id));

% Converts the dates into number form
    i_datenum  = datenum(i_date);
    o_datenum = datenum(o_date) - 1/24 + 1;
     
% Find the starting and end row numbers
    start_row = find(data(:,1) == i_datenum,1);
    end_row   = find(data(:,1) == o_datenum,1); 

    if isempty(start_row) || isempty(end_row)     
        error('Error caused by not matching dates. Choose other time');  
    end
    
% Combines the date and time into number then to string type     
    date_time = data(start_row:end_row,1);

% Outputs measured data point and converts from degF to degC
if date_time(1) == datenum('8-apr-2013')
    meas_data = data(start_row+23:end_row+23,col);
elseif date_time(1) == datenum('1-jan-2014')
    meas_data_ini = data(end-23:end,col);
    meas_data_sec = data(start_row:end_row-24,col);
    meas_data = [meas_data_ini; meas_data_sec];
    
elseif date_time(1) == datenum('25-nov-2013') || date_time(1) == datenum('5-feb-2014')
     meas_data = data(start_row-24:end_row-24,col);
else
    meas_data = data(start_row:end_row,col);
end
    
end

