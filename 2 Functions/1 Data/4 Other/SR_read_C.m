function [data_final, header_final] = SR_read_C(loadpath_T,filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loads the data collected with Smart Readers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [data,header] = xlsread([loadpath_T,filename]);

    file_SR = header{8,2}; % file name

    % We remove and resize the data matrix
    data_new = data(10:end,1:end); 

    % Adding the date and time to two columns
    data_final(:,1)  = datenum(header(11:end,1),'dd/mm/yyyy');
    data_final(:,2)  = datenum(header(11:end,1),'dd/mm/yyyy HH:MM:SS PM');
    data_final(:,2)  = data_final(:,2) - data_final(:,1);

    data_final = [data_final, data_new];
    header_final = {'Date', 'Time', strcat(file_SR,'_1'),strcat(file_SR,'_2'),strcat(file_SR,'_3')};
    
savepath = '...';
savename = file_SR;
    
save([savepath,savename],'data_final','header_final');

end

