%function [] = import_eq(yea)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALISATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Yearly path
%path = '...\V3 - Exhaust Comp\V3.4 No_fanSCH\';

% Shoulder path

% Baseline
%path = '..\4 Baseline\V8 Baseline\';
%path = '...\6 Loads Tune\V6_1 Base Loads Tune\';
%path = '...\6 Loads Tune\V6_2 Base Loads Tune\';

% 2013 Shoulder Season test
%path = '...\7 Shoulder Calibration\7 Final\';
%path = '...\V1 Ini_heat\Test_cntrl\';

% 2013 Heating path
%path = '...\V1 Ini_heat\';
%path = '...\V1_2 Ini_heat\';
%path = '...\V1_3 Ini_heat\';
%path = '...\V1_4 Ini_heat\';

% 2014 Heating path
%path = '...\V2_1 Heat14\';
path = '...\V2_2 Heat14\';
%path = '...\V2_3 Heat14\';

% Basement
%path = '...\V1 Initial Basement\';

savename = '...\eQ_data';

list=ls([path,'*Hourly Results.csv']);

h=1;

[data,header]=xlsread([path,list(h,:)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if str2num(o_date(end-3:end)) - str2num(i_date(end-3:end)) > 0

   for i=1:8760/2
      year(i) = str2num(o_date(end-3:end));
   end
   
   for i=i:8760
      year(i) = str2num(i_date(end-3:end));
   end
    
    
else
    
if season == 2013
    year(1:8760) = 2013;
elseif season == 2014 || H2014
    year(1:8760) = 2014;
end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now we combine the date from eQUEST output: Month, day, hour
for i=1:size(data,1)

date_comb(i) = datenum(year(i),data(i,1),data(i,2),data(i,3)-1,0,0); 

end

% In the current case, there are 4 columns before the important data starts

data_final = zeros([size(data,1) size(data,2)-3]);

data_final(:,1) = date_comb(:);

data_final(:,2:end) = data(:,5:end);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATING THE NEW HEADER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The header created by equest cannot be used to identify each variable so
% we will need to recreate the header.

% There is also a lot of data that we do not need to be output by equest so
% we will also get remove that from the data file and recreate a new matrix
% with only the information that we need.


% 28 after 3 for the days

header1 = {
%Zone
%First Floor

'Date'

'Z1_NE_T'
'Z1_NE_q'
'Z1_NE_Me'
'Z1_NE_Ms'
'Z1_NE_qz'

'Z1_S_T'
'Z1_S_q'
'Z1_S_Me'
'Z1_S_Ms'
'Z1_S_qz'

'Z1_NW_T'
'Z1_NW_q'
'Z1_NW_Me'
'Z1_NW_Ms'
'Z1_NW_qz'

'Z1_CONF_T'
'Z1_CONF_q'
'Z1_CONF_Me'
'Z1_CONF_Ms'
'Z1_CONF_qz'

'Z1_CORR_T'
'Z1_CORR_q'
'Z1_CORR_Me'
'Z1_CORR_Ms'
'Z1_CORR_qz'

%Second Floor

'Z2_SE_T'
'Z2_SE_q'
'Z2_SE_Me'
'Z2_SE_Ms'
'Z2_SE_qz'

'Z2_E_T'
'Z2_E_q'
'Z2_E_Me'
'Z2_E_Ms'
'Z2_E_qz'

'Z2_INT_T'
'Z2_INT_q'
'Z2_INT_Me'
'Z2_INT_Ms'
'Z2_INT_qz'

'Z2_W_T'
'Z2_W_q'
'Z2_W_Me'
'Z2_W_Ms'
'Z2_W_qz'

'Z2_S_T'
'Z2_S_q'
'Z2_S_Me'
'Z2_S_Ms'
'Z2_S_qz'

'Z2_NE_T'
'Z2_NE_q'
'Z2_NE_Me'
'Z2_NE_Ms'
'Z2_NE_qz'


%Third Floor

'Z3_W_T'
'Z3_W_q'
'Z3_W_Me'
'Z3_W_Ms'
'Z3_W_qz'

'Z3_NE_T'
'Z3_NE_q'
'Z3_NE_Me'
'Z3_NE_Ms'
'Z3_NE_qz'

'Z3_INT_T'
'Z3_INT_q'
'Z3_INT_Me'
'Z3_INT_Ms'
'Z3_INT_qz'

'Z3_E_T'
'Z3_E_q'
'Z3_E_Me'
'Z3_E_Ms'
'Z3_E_qz'

'Z3_SE_T'
'Z3_SE_q'
'Z3_SE_Me'
'Z3_SE_Ms'
'Z3_SE_qz'

'Z3_S_T'
'Z3_S_q'
'Z3_S_Me'
'Z3_S_Ms'
'Z3_S_qz'

% Global
'Toa_eq'
'W_eq'
'Yr_eq'
'Mo_eq'
'Day_eq'
'Hr_eq'
'DaYr_eq'

%AHU System
'Tht_eq'   % Does not make sense!!
'Tcd_eq'
'Tm_eq'    % Temp entering coils...?
'Tr_eq'    % Downstream of the fans and plenum
'qht_eq'   % Heating coil energy
'qcd_eq'   % Cooling Coil energy (cold deck)
'qzone_eq' % Zone heating coil output (Btu/h)
'qph_eq'   % Preheat heating coil output
'qH_eq'    % Humidification heat output (Btu/h)
'Ms_eq'
'Mr_eq'
'Me_eq'  % Total zone exhaust flow rate
'Wr_eq'  
'Wm_eq'
'Wcd_eq'
'H_water' % lbs of water added to the air stream
'a_eq'
'Pfan_eq' % kW
'FR_eq' % Fan ratio flow rate (cfm/design cfm)
'dT_sfan'
'dT_rfan'
'Mrel_eq' % Return.relief fan..?
'Moa_eq' % Outdoor airflow through the ERV (what about bypass?)
'Mefan_eq' % Exhaust Fan (CFM)
'Eerv_eq' % Sensible effectiveness
'qerv_eq' % Sensible preheat heat transfer (Btu/h) 
'Terv_eq'  % ERV Preheat Temperature
'BPerv_eq' % (%)of OA bypassed around ERV
'qdPhr_eq'    % Extra fan power caused by heat recovery

% Hot Water Loop-1
'Mhw_eq' % Flow rate of hot water gpm
'q_hw_eq' % btu/h..?
'Thwa_sp_eq' % Control hot water setpoint temp.
'Thwa_eq' % Actual hot water supply temp.
'Thwr_eq' % Temp. leaving coils.
};

%% Save data
date   = date_comb;
data   = data_final;
header = header1;
save(savename,'data','header','date');











