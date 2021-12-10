function [ meas_new ] = BAS15_5( t_5,t_15, meas )
% Interpolates 15 min BAS trend data to 5 min data
% for comparison purposes


% Test to see if the starting point is less than the trend data
% if so, the first 5 min data simply equals the first bas trend data

% time must be in number format!!


for j=1:length(t_5);

k=1;

 while t_5(j) - t_15(k) > 15/(60*24)
     k=k+1;
 end
 
%   while t_5(j) < t_15(k)
%      k=k+1;
%  end
 

    if minute(t_5(j)) - minute(t_15(k))  == 0
        meas_new(j) = meas(k); 
    elseif minute(t_5(j)) - minute(t_15(k)) == 5
        meas_new(j) = 2/3*meas(k) + 1/3*meas(k+1);
    elseif minute(t_5(j)) - minute(t_15(k))
        meas_new(j) = 1/3*meas(k) + 2/3*meas(k+1);
    end

meas_new = meas_new';
end














% i=1;
% k=1;
% while t_5(1) - t_15(k) > 15/(60*24)
%     k=k+1;
% end
% 
% 
% while t_5(i) < t_15(1)
%     meas_new(i) = meas(1);
%     i=i+1;
% end
% 
% h=i;
%     
% for j=h:length(t_5)-h-1
%     
%     if minute(t_5(j)) - minute(t_15(k))  == 0
%         meas_new(j) = meas(k); 
%     elseif minute(t_5(j)) - minute(t_15(k)) == 5
%         meas_new(j) = 2/3*meas(k) + 1/3*meas(k+1);
%     elseif t_5(j) - t_15(k) == 10
%         meas_new(j) = 1/3*meas(k) + 2/3*meas(k+1);
%     end
%    k=k+1; 
% end





end

