function [ R ] = R2_calc(x,y,f)
%% Models the R^2 of y (measured value) and f (function value)

SS_tot = zeros(length(y));
SS_res = zeros(length(y));

for i=1:length(y)
SS_tot(i) = (y(i)-nanmean(y))^2;
SS_res(i) = (y(i)-polyval(f,x(i)))^2;
end
R = 1-nansum(SS_res) / nansum(SS_tot);

end

