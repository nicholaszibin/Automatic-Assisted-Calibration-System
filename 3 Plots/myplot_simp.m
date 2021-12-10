function [axplot]  = myplot_simp(t,var_plot)
hold on
days = floor(t(end)+1)-floor(t(1));

axplot = plot(t,var_plot,'LineWidth',1);

if t(1) == datenum('8-apr-2013')
    step = 3;
elseif t(1) == datenum('7-jan-2013') || t(1) == datenum('5-feb-2014')
    step = 21;
elseif t(1) == datenum('25-nov-2013')
    step = 28;
else
    step = 7;
end
%step=3;

%xData_day = linspace(floor(t(1)),floor(t(end)+1),days/7+1);
%xData_day = linspace(floor(t(1)),floor(t(end)+1),days+1);
Data_day = floor(t(1)):step:floor(t(end)+1);

set(gca,...
  'Box'         , 'on'      , ...
  'FontName'    , 'Avant Garde', ...
  'FontSize'    , 10         , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.015 .015] , ...
  'YMinorTick'  , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'XTick'       , Data_day     , ...
  'XGrid'       , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
 datetick('x','dd-mmm (DDD)','keepticks');
 %datetick('x','dd-mmm','keepticks');
 xlim([floor(t(1)) floor(t(end)+1)]);
 
hold off

end

