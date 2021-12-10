function [meas_out dat_time] = database_fetch(var,meas_id,in_dat,out_dat,filen )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes the data string name and for many variable names.
% It is ideally used for average and summing temperature and air flow rates
% respectively. Very useful when analyzing zone data.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

meas_ret = cell(1,length(meas_id));

for i=1:length(meas_id)
  [meas_ret{i} dat_time] = data_fetch(meas_id(i),in_dat,out_dat,filen); 
end

if var == 'sum'
  for i = 1:length(meas_id)
    for j=1:length(dat_time)
      if isnan(meas_ret{i}(j))
        meas_ret{i}(j) = 0;
      endif
    endfor
  endfor
elseif var == 'avg'
else
  error('Choose "avg" or "sum" only.');  
endif

meas_row{1} = meas_ret{1};
  
for i = 2:1:length(meas_id) 
  meas_row{1} = meas_ret{i} + meas_row{1};     
endfor

if var == 'sum'
  meas_row = cell2mat(meas_row);
elseif var == 'avg'
  meas_row = cell2mat(meas_row)/length(meas_id);
endif

meas_out = meas_row;

endfunction

