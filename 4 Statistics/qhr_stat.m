function [ M R C ] = qhr_stat(t,qhr,t_eq,qhr_eq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates the NMBE and CV(RMSE) of heat recovery
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=1;

for j = 1:length(t)
for i = 1:length(t_eq)
    
if t(j) == t_eq(i)

    q_1(k) = qhr(j);
    q_2(k) = qhr_eq(i);
    
    k = k+1;
    
end

end
end

M = MBE(q_1,q_2);
R = RMSE(q_1,q_2);
C = CV_RMSE(q_1,q_2);

end

