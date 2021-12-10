function [ meas_data date_time ] = eQ_get(type,meas_id,i_date,o_date,filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and
% Type:
% N = no type
% T = Temperature
% q = heat flow rate
% M = Volumetric flow rate (air)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if str2num(o_date(end-3:end)) - str2num(i_date(end-3:end)) > 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This becomes complicated due to the format of the weather file...
% First we read in the in date from the 2nd of january to the out date.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    i_date_new = ['1-jan-' o_date(end-3:end)];
    o_date_new = ['31-dec-' i_date(end-3:end)];
    
    [meas_data_1 date_time_1] = eQ_fetch(meas_id,i_date,o_date_new,filename);
    [meas_data_2 date_time_2] = eQ_fetch(meas_id,i_date_new,o_date,filename);

    meas_data = [ meas_data_1; meas_data_2];
    date_time = [ date_time_1; date_time_2];
    
else
        [meas_data date_time] = eQ_fetch(meas_id,i_date,o_date,filename);
end

switch type
    case 'N'
    case 'T'
        meas_data = F_T(meas_data);% F to C
    case 'q'
        meas_data = -0.29307 / 1000 * meas_data; % Btu/hr to kW
    case 'M'
        meas_data = 0.472 * meas_data; % 
    otherwise
        disp('Did not correctly specify TYPE');
end

if str2num(o_date(end-3:end)) - str2num(i_date(end-3:end)) > 0

%     i_last_row = datenum('31-dec-2013 23:00:00');
%     
%     i_date_fix = datenum('1-jan-2014 00:00:00');
%     for i=1:24
%        date_fix(i) =  i_date_fix + (i-1)/24;
%     end
%     date_fix = date_fix';
%     
%     start_row = find(date_time == i_last_row,1);
%     miss_data(1:24) = NaN;
%     miss_data = miss_data';
%     
%     meas_data = insertrows(meas_data,miss_data,start_row);
%     date_time = insertrows(date_time,date_fix,start_row);

end

meas_data = meas_data';

end

