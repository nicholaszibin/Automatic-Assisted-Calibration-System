function [axplot]  = myplot_SCH( Toa,var_plot,t,on)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Seperates a Toa plot into day/night and weekday/weekend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%Chosen schedule for day/night
day_start = 7/24;
day_end   = 19/24;

k=1;
h=1;
j=1;
for i=1:length(t)

    % If it is night time
    if t(i)-floor(t(i)) > day_end || t(i)-floor(t(i)) < day_start
    
        Toa_N(k) = Toa(i);
        var_N(k) = var_plot(i);
        k=k+1;
    
    % If it is a weekday
    % Sunday = day 1, Saturday = day 7
    elseif weekday(t(i)) == 7 || weekday(t(i)) == 1
        
        Toa_we(h) = Toa(i);
        var_we(h) = var_plot(i);
        h=h+1;
    
    % Plotting Day values    
    else
        
        Toa_D(j) = Toa(i);
        var_D(j) = var_plot(i);
        j=j+1;
        
end
end

% Some plots might only include a few hours so we must account for
% variables that do not rightfully exist
hold on
if exist('Toa_N')
axplot(1) = plot(Toa_N,var_N,'LineStyle','none','Color','r','Marker','x');
end

if exist('Toa_we')
axplot(2) = plot(Toa_we,var_we,'LineStyle','none','Color','k','Marker','o');
end

if exist('Toa_D')
axplot(3) = plot(Toa_D,var_D,'LineStyle','none','Color','b','Marker','.');

end

%% Creating a legned if required.
if nargin > 3;

    hLegend = legend( ...
        [axplot(1), axplot(2), axplot(3)], ...
        'Night schd.', ...
        'Weekend schd.',...
    	'Day schd.', ...
        'location', 'NorthEast');
end

set(gca,...
  'Box'         , 'off'      , ...
  'FontName'    , 'AvantGarde', ...
  'FontSize'    , 10         , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.015 .015] , ...
  'YMinorTick'  , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'XGrid'       , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'LineWidth'   , 1         ); 

hold off
end

