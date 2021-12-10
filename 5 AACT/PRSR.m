function [out] = PRSR(in,ts,pr,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROCESSOR:
% Processes data
% in = variable(s) to be processed 
% ts = time step wanted
% pr = processing type (e.g., median (AVG) or summation (SUM)) 
% x  = x-axis data (e.g., time or outdoor air temperature) (not required)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if varargin < 4
    x = 1:length(in);
end

out = cell(1,length(in));
for i=1:length(out)
    [out{i} dat_time] = data_fetch(meas_id(i),in_dat,out_dat,filen);
end

switch pr
    case 'AVG'
    case 'SUM'
end


end

