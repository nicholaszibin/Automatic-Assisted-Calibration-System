function [ e_out ] = NTU_ERV(edes,e_in,Voa,Vdes)
%% Outputs the expected effectiveness simulated in eQUEST
Vdes = Vdes * 2.11888;
Voa  = Voa  * 2.11888;
Cdes = Vdes * 1.08;
C    = 1;
Senres   = 0.4;
Senfilm  = 0.2;

% Solve for NTU and DESIGN UA
NTU = fzero(@(NTU) e_in - (1-exp((exp(C * -NTU^0.78)-1)/(C * NTU^-0.22))),1.26);
UA = NTU * Cdes;

Rtotal     = 1/UA;
Rmedia     = Rtotal * (1-Senres);
Rfilm      = (Rtotal-Rmedia) * 0.5;
UAfilm     = 1 / Rfilm;
UAfilmCoef = UAfilm / (Vdes^Senfilm);    
MinFlow    = Vdes * 0.3;

UAoa    = UAfilmCoef * max(Voa,MinFlow)^Senfilm;
Roa     = 1 / UAoa;
Rhx     = 2 * Roa + Rmedia;
UAsim   = 1 / Rhx;

NTUsim = UAsim / (Voa * 1.08);

e_eq = 1-exp((exp(C * -NTUsim^0.78)-1)/(C * NTUsim^-0.22));
e_out = e_eq - edes; 
end




