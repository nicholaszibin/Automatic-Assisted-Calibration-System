function [meas_data, date_time] = data_fetch_h (meas_id,in_date,out_date,filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% _h refers to using hourly averaged data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(['all',filename]);

[meas_data date_time] = data_fetch(meas_id,in_date,out_date,filename);
meas_data = hour_avg(meas_data);
date_time = time_avg(date_time);
endfunction


