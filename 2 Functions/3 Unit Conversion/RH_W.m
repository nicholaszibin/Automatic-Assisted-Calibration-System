function [ W ] = RH_W( T,RH )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates humidity ratio given the dry bulb temp of air and the relative
% humidity of air.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculating pws - Partial pressure


for i=1:length(T)
if T(i) < 0
  T_i = T(i) + 273.15;
    
  C1 = -5.6745359*10^3;
  C2 = 6.3925247;
  C3 = -9.6778430*10^-3;
  C4 = 6.2215701*10^-7;
  C5 = 2.0747825*10^-9;
  C6 = -9.4840240*10^-13;
  C7 = 4.1635019;
  
  pws(i) = exp(C1/T_i + C2 + C3*T_i + C4*T_i^2 + C5*T_i^3 + C6*T_i^4 + C7*log(T_i));
  
else
  T_i = T(i) + 273.15;
    
  C1 = -5.8002206*10^3;
  C2 = 1.3914993;
  C3 = -4.8640239*10^-2;
  C4 = 4.1764768*10^-5;
  C5 = -1.4452093*10^-8;

  C7 = 6.5459673;
    
  pws(i) = exp(C1/T_i + C2 + C3*T_i + C4*T_i^2 + C5*T_i^3 + C7*log(T_i));
  
end
end

p = 101.325*1000;


pw = RH.*pws;

W = 0.621945.*pw./(p - pw);

end

