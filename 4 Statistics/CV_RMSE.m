function [cv_rmse_out] = CV_RMSE(x1,x2)
%% This function calculates CV of RMSE

[x1x2_rmse mean_x1] = RMSE(x1,x2);


cv_rmse_out = x1x2_rmse/mean_x1;


end

