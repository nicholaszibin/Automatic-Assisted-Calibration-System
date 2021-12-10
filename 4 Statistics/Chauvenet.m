function [ data ] = Chauvenet( data )
%Uses chauvenets method to remove outliers

data_std = nanstd(data);

n = length(data);

d_max = (0.819 + 0.55 * log(n) - 0.02346*log(n^2)) * data_std;

data_avg = nanmean(data);

for i=1:length(data)
   
    if abs(data(i)- data_avg) >= d_max
    
        data(i) = NaN;
    end   
end


end

