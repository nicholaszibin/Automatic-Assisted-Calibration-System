function [] = AACS_misc(eQ,eQ_var,inp_loc,inp_name )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script automatically updates the eQUEST input file (.inp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose('all');

% Location of input file
% Ex. inp_loc  = '...';
% Ex. inp_name = 'GE_SH_v6_3_FT_loads'; 
%
% eQ_var is, for example: Ms_design
% 
% eQ contains:
% Z2_Ms_max = {...   
%     '"EL2 SE Zone (f2.z1)"'  , Z2_SE.Ms_max * 2.11888
%     '"EL2 E Zone (f2.z2)"'   , Z2_SE.Ms_max * 2.11888
%     '"EL2 INT Zone (f2.z6)"' , Z2_SE.Ms_max * 2.11888};

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
          
        while repeat == 0 
            
            j=j+1;
            H{j} = fgetl(fileID);
            
            if ~isempty(strfind(H{j},eQ_var))
                    
                   H{j} = ['   ',eQ_var,'    = ',num2str(eQ{i,2}) ,' $ AACS'];
                   repeat = 1;     
            end  
        end
       
       
   end 
   
    if strfind(H{j},'STOP ..') > 0
        eq_end = 1;
    end
     
   j=j+1;
end


%% Save as a new file

fclose('all');

[fileID,errmsg]  = fopen([inp_loc,inp_name,'.inp'],'w');


while fileID < 0 
   disp(errmsg);
end

for f = 1:length(H)
fprintf(fileID,'%s \r\n',H{f});
end
end

fclose('all');
end

