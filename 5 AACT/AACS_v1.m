%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script automatically updates the eQUEST input file (.inp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all');
clear all;
clc;

% Location of input file
inp_loc  = '...';
inp_name = 'GE_SH_v6_3_FT_loads'; 


% Value from BAS trend data
Ms_design  = '60000';

% eQUEST variable name
eq_name = 'SUPPLY-FLOW';

[fileID,errmsg]  = fopen([inp_loc,inp_name,'.inp']);

while fileID < 0 
   disp(errmsg);
end

%% Search within eQUEST when the variable name is found
eq_end  = 0;
i=1;
while  eq_end == 0;
    
   H{i} = fgetl(fileID);
   
   if strfind(H{i},eq_name) > 0
       H{i} = ['',eq_name,' = ',Ms_design];
   end
   
   
    if strfind(H{i},'STOP ..') > 0
        eq_end = 1;
    end
     
   i=i+1;
end
fclose('all');

%% Save as a new file

[fileID,errmsg]  = fopen([inp_loc,inp_name,'_AACS.inp'],'w');

for i = 1:length(H)
fprintf(fileID,'%s \r\n',H{i});
end
fclose('all');
