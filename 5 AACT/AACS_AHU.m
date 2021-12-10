function [] = AACS_AHU(eQ,inp_loc,inp_name )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script automatically updates the eQUEST input file (.inp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all');

% Location of input file
% Ex. inp_loc  = '..';
% Ex. inp_name = 'GE_SH_v6_3_FT_loads'; 
% Value from BAS trend data
% Ex. Ms_design  = '65000';
% eQUEST variable name
% Ex. eq_name = 'SUPPLY-FLOW';

%% Now we go through the list and update each file
for i=1:size(eQ,1)
fclose('all');
[fileID,errmsg]  = fopen([inp_loc,inp_name,'.inp']);

while fileID < 0 
   disp(errmsg);
end

% Search within eQUEST when the variable name is found

repeat  = 0;
eq_end  = 0;
j       = 1;

while  eq_end == 0;
    
   H{j} = fgetl(fileID);
 
   
    if ~isempty(strfind(H{j},eQ{i,1})) && repeat == 0
       H{j} = ['   ',eQ{i,1},' = ',num2str(eQ{i,2}) ,' $ AACS'];
       repeat = 1;     
   end 
   
    if strfind(H{j},'STOP ..') > 0
        eq_end = 1;
    end
     
   j=j+1;
end


%% Save as a new file

fclose('all');

% We rename the file as to not overwrite the previous file
if i == 1   
    inp_name = [inp_name,'_AACS'];  
end

[fileID,errmsg]  = fopen([inp_loc,inp_name,'.inp'],'w');


while fileID < 0 
   disp(errmsg);
end

for i = 1:length(H)
fprintf(fileID,'%s \r\n',H{i});
end
end

fclose('all');
end

