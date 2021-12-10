%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EDIT eQUEST WEATHER FILE
% This File reads weather data from BAS and write is the weather file that
% was transfered to txt using the BIN2TXT.BIN function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all'); close all; clear all; clc;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHOOSE WEATHER FILE and LOCATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

weather_file = 'montreal(dorval)_BAS2014_AACS';
weather_loc = 'C:\Users\n_zibin\Documents\eQUEST 3-64 Data\Weather\CWEC\'; % Example file location

% Now we find the start and end line positions of the dates that we want 
% to replace.

i_date = '22-nov-2013';    %In Date
o_date = '31-dec-2013';   %Out Date - The end time is 20-apr-2013 24:00:00
leapyear = 1;

% Download the BIN2TXT.EXE file here:
% http://doe2.com/index_Wth.html
% Direct link:
% http://doe2.com/download/weather/DOE22WeatherUtilities.ZIP
BIN2TXT_loc = 'C:\Users\n_zibin\Documents\eQUEST 3-64 Data\Weather\DOE22\UTIL32\';

% Copy and rename the file to the folder containing the function
% BIN2TXT.EXE. The name of the bin file in this folder must be called
% WEATHER.BIN or else the function does not work.
% However first we will remove any WEATHER.BIN or WEATHER.FMT (the text 
% output) files.

if exist([BIN2TXT_loc,'WEATHER.BIN']) > 0
            delete([BIN2TXT_loc,'WEATHER.BIN'])
elseif exist([BIN2TXT_loc,'WEATHER.FMT']) > 0
            delete([BIN2TXT_loc,'WEATHER.FMT'])
end
pause(2);
copyfile([weather_loc,weather_file '.BIN'],[BIN2TXT_loc,'WEATHER.BIN']);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONVERT TO TEXT FILE AND LOAD INTO MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This runs the BIN2TXT.EXE file. The output is a text file called
% WEATHER.FMT which can be opened using a notepad program.
winopen([BIN2TXT_loc,'BIN2TXT.EXE'])

pause(2);

[fileID,errmsg]  = fopen([BIN2TXT_loc,'WEATHER.FMT']);

while fileID < 0 
   disp(errmsg);
end

% There are two types of eQUEST weather files: One with solar data and one
% without. This is approximately the format of the of a solar eQUEST
% weather file. Later on a more precise format to write the new data back
% is used.
myformat = '%6c %4f %4f %4f %2f %d %d %2d %6f %5f %4f %5f %5f %d %3f \r\n';

% Read the file into matlab 
% The header has 3 lines
H{1}=fgetl(fileID);
H{2}=fgetl(fileID);
H{3}=fgetl(fileID);

A = textscan(fileID,myformat);
fclose('all');
% The weather file is not in the variable A. Lets explain this variable:
% A{1}  ->  Time           [Month(1-12) Day(1-31) Hour(1-24)]
% A{2}  ->  Wet bulb temp. [nearest whole degF]
% A{3}  ->  Dry bulb temp. [nearest whole degF]
% A{4}  ->  Pressure       [nearest tenth (inches in Hg)]
% A{5}  ->  Cloud amount   [1-10]
% A{6}  ->  Snow flag      [1 = snowfall]
% A{7}  ->  Rain flag      [1 = rainfall]
% A{8}  ->  Wind direction [16ths of a circle (0-15). 0 is north]
% A{9}  ->  Humidity ratio [nearest .0001 (lbs H20/lbs dry air)]
% A{10} ->  Air density    [nearest .001 (lbs/ft^3)] 
% A{11} ->  Air enthalpy   [nearest .5(Btu/lb)]
% A{12} ->  Total horizontal solar radiation [nearest whole Btu/ft^2]
% A{13} ->  Direct normal solar radiation    [nearest whole Btu/ft^2]
% A{14} ->  Cloud type     [0,1,or 2]               
% A{15} ->  Wind speed     [nearest whole knots]

%% This section can be ignored because it does some very tedious matlab
%% calculations to correctly process the eQUEST time format.
% Matlab has difficulty reading the dates from the weather file so we must
% use a trick to correctly read the date. The reason this is done is
% because matlab cannot deal well with leading zeroes. 
% The ultimate goal is to first read the time from the file to know which 
% line to start replacing the data.
%
% The format of this data is MM:DD:HH (1-24h)

% First the whitespaces are replaced with zeroes.
for i=1:length(A{1})
    for j=1:6
        Dat(i,j) = strrep(A{1}(i,j),' ','0');
    end
end

% Next the maximum number of characters in the date before September 1st 
% (10 01 01) is 5. After 10 01 01 there are 6 characters. We remove the
% ending zero from all dates before 10 01 10

Six_digits = '100101';

for i=1:length(A{1})
    if Dat(i,:) == Six_digits
        break
    end
    Dat(i,6) = '.';
end

% We convert the date to a numbeer
for i=1:length(A{1})
   Date_eq(i) = str2num(Dat(i,:)); 
end
Date_eq = Date_eq';

%% Again, this step can be ignored. It is tedious matlab functions to find
%  the starting row for data replacement.

% Input start date
MM{1} = datestr(i_date,'mm');
DD{1} = datestr(i_date,'dd');
HH{1} = str2num(datestr(i_date,'hh'));
HH{1} = num2str(HH{1} + 1); % eQUEST starts date at 1h-24h

% Output end date
MM{2} = datestr(o_date,'mm');
DD{2} = datestr(o_date,'dd');
HH{2} = str2num(datestr(o_date,'hh'));
HH{2} = num2str(HH{2} + 24); % eQUEST starts date at 1h-24h

% We need to add a zero to the front of the hour incase it is less than 10.
for i=1:2
   if str2num(HH{i}) < 10
       HH{i} = strcat('0',HH{i});
   end
end

Date_BAS{1} = str2num(strcat(MM{1},DD{1},HH{1}));
Date_BAS{2} = str2num(strcat(MM{2},DD{2},HH{2}));

% Now we search for the starting line for the dates we want to repalce

% Watch out for leap years!!

start_row = find(Date_eq == Date_BAS{1},1);
end_row   = find(Date_eq == Date_BAS{2},1);

if leapyear == 1
   start_row = start_row - 24;
   end_row   = end_row - 24; 
end

%% Load data for replacement. In this example I use outdoor air temperature
% collected by a building automation system (BAS). 
% What you need to do is insert your data, for example:
%   filename = 'my_Toa_BAS.xlsx';
%   Toa = xlsread(filename,'A:A') %The Toa data is in column A.

f_T  = 'DATA_T.mat';
f_Tp = 'DATA_Tp.mat';

[Toa t ]   = data_fetch_h('MTX612BS', i_date, o_date, f_T);
Toa = 32 + (1.8 * Toa');

% figure
% hold on
% plot(t,A{3}(start_row:end_row),'r');
% plot(t,Toa);
% hold off

%CV_RMSE(1/1.8.*(Toa-32),1/1.8 .* (A{3}(start_row:end_row)-32))

% Replace the data in weather the file
B=A{3}(start_row:end_row);

% Replace NaN values recorded with the ones that were in the original
% eQUEST weather file.

h=1;
for i=start_row:end_row

        if isnan(Toa(h));
            A{3}(i) = A{3}(i); 
        else
            
            A{3}(i) = round(Toa(h));
        end

    h=h+1;
    
end

% figure
% hold on
% plot(t,A{3}(start_row:end_row),'r');
% plot(t,B);
% hold off
% 
% figure
% plot(t,B-A{3}(start_row:end_row))

delete([BIN2TXT_loc,'WEATHER.FMT'])
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOAD DATA BACK INTO A NEW FMT FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[fileID,errmsg]  = fopen([BIN2TXT_loc,'WEATHER.FMT'],'w');

for i=1:8760
    for j=1:15
        New_eq{i,j} =  A{j}(i,:); 
    end
end

% Now we add the leading zeroes
for i=1:8760
if length(strtrim(A{1}(i,:))) < 6
    New_eq{i,1} = [' ',A{1}(i,1:5)];
end
end

% Print the header to the file first:
fprintf(fileID,'%s \r\n',H{1});
fprintf(fileID,'%s \r\n',H{2});
fprintf(fileID,'%s \r\n',H{3});

%for i=start_row:end_row
for i=1:8760
       test(i)= fprintf(fileID,'%6s %4.0f %4.0f %5.1f %4.0f %2d %2d %3d %6.4f %5.3f %5.1f %6.1f %6.1f %2d %4.0f \r\n',New_eq{i,:});  

end
fclose('all');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN TXT2BIN.EXE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist([BIN2TXT_loc,'WEATHER.BIN']) > 0
            delete([BIN2TXT_loc,'WEATHER.BIN'])
end
pause(2);

% This runs the TXT2BIN.EXE file. The output is a text file called
% 'WEATHER_BAS_EDIT_auto.BIN' in the ...\eQUEST 3-64 Data\Weather\CWEC\
% directory.
winopen([BIN2TXT_loc,'TXT2BIN.EXE'])
pause(2);

copyfile([BIN2TXT_loc,'WEATHER.BIN'],[weather_loc, weather_file, '_AACS.BIN']);
