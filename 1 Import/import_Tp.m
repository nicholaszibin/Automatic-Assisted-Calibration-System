%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALISATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;

path='...';
savename='allDATA_Tp';

list=ls([path,'*.csv']);
% list(1:13,:)=[];
debut=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for h=1:size(list,1)
    [data,header]=xlsread([path,list(h,:)]);
    header1=['Date';'Time';header(2:size(header,2)-1,2)]';      
    header(1:size(header1,2)+3,:)=[];
    header(end,:)=[];
    header(1,:)=header1;
    ajout = size(header,2)-1-size(data,2);

    data=[datenum(header(2:end,1)) data NaN(size(data,1),ajout)];
    
    a=isnan(data);
    b=sum(a,1);
    c=find(b>0);
    
   for i=1:size(data,1)
        for j=1:size(c,2)
            switch char(header(i+1,c(j)))
                case 'ON'
                    data(i,c(j))=100;
                case 'OFF'
                    data(i,c(j))=0;
                case 'Open'
                    data(i,c(j))=100;
                case 'CLOSED'
                    data(i,c(j))=0;
                case 'No Data'
                    data(i,c(j))=NaN;
                case 'NaN'
                    data(i,c(j))=NaN;
                case 'Data Loss'
                    data(i,c(j))=NaN;
            end
        end
   end
    
    fin=debut+size(data,1)-1;
        
    data_final(debut:fin,1:length(header1))=data;
    
    debut=size(data_final,1)+1;
    
    header_final=header(1,:);
end

% The file may have missing dates which will not help using both trend data
% simultaneously

in_row_dat(3:size(data_final,2)) = NaN; 

dftest = data_final;

for k=1:size(dftest,1)-1

    if (data_final(k+1,1)+data_final(k+1,2))-(data_final(k,1)+data_final(k,2)) >= 1.001*15/60/24  %To avoid rounding erros
        
        in_row_dat(1) = data_final(k,1);
        in_row_dat(2) = data_final(k,2) + 15/60/24;
        
        data_final = insertrows(data_final,in_row_dat,k);
        k=k-1;
    else
    end
end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVING DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
date=[datestr(data_final(:,1)) datestr(data_final(:,2),' HH:MM:SS')];
data=data_final;
header=header_final;
save(savename,'data','header','date');