function [ str ] = Hour_val2str( var )
%% Converts a number sequence [21 22 23 24 25 21]
% to
% '21, 22, 23, 24, 25, 21,' 
% 
% Is binary for endline for endline
% ex. '21, 22, 23, 24, 25, 21)
%
%    VALUES = ( 71.4, 71.3, 71.2, 71.15, 71, 71, 71, 71, 71.4, 72.5,            
%          73.5, 74.1, 74.6, 74.8, 75.1, 75.3, 75, 74.4, 73.8, 73, 72.4, 71.9,            
%          71.6, 71.6 )

%var = [ 71.4, 71.3, 71.2, 71.15, 71, 71, 71, 71, 71.4, 72.5,73.5, 74.1, 74.6, 74.8, 75.1, 75.3, 75, 74.4, 73.8, 73, 72.4, 71.9,71.6, 71.6 ];

str = cell(3,1);

str{1} = ['VALUES = ( ', var{1}, ', ' ];

for i =2:8
   
    str{1} = [str{1}, var{i}, ', ' ];    
    
end

for i =9:16
   
    str{2} = [str{2}, var{i}, ', ' ];    
    
end

for i =17:24
   
    str{3} = [str{3}, var{i} ',' ];    
    
end

str{3}(end) = ')';

str{3} = [str{3} ' $AACS'];

end

