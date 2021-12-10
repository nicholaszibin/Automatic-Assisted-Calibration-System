function [max min Toa_space] = max_min_error(Toa,in,err)

%Calculates the max and min error per outside air temperature

Toa_space = linspace(nanmin(Toa),nanmax(Toa),ceil(nanmax(Toa)-nanmin(Toa)));
diff = Toa_space(2)-Toa_space(1);

for k=1:length(Toa_space)
    max_ind = 0;
    min_ind = 0;
    if k == 1
        ind = find(abs(Toa-Toa_space(k))<diff/2);
                for n=1:length(ind)
                     max_ind(n) = (1+err).*in(ind(n));
                     min_ind(n) = (1-err).*in(ind(n));
                end
            max(k) = nanmax(max_ind);
            min(k) = nanmin(min_ind);
            
    elseif k == length(Toa_space)
        ind = find(abs(Toa-Toa_space(k))<diff/2);
                for n=1:length(ind)
                     max_ind(n) = (1+err).*in(ind(n));
                     min_ind(n) = (1-err).*in(ind(n));
                end
            max(k) = nanmax(max_ind);
            min(k) = nanmin(min_ind);      
        
    else
        ind = find(abs(Toa-Toa_space(k))<=diff);
                for n=1:length(ind)
                     max_ind(n) = (1+err).*in(ind(n));
                     min_ind(n) = (1-err).*in(ind(n));
                end
            max(k) = nanmax(max_ind);
            min(k) = nanmin(min_ind);
    end
end
end

% for i=1:length(Toa)
%     if ~isnan(Toa(i))
%     
%         
%       ind = find(abs(Toa-Toa(i))<2);
%   if  ind > 1    
%      for n=1:length(ind)
%       max_ind(n) = (1+err).*in(ind(n));
%       min_ind(n) = (1-err).*in(ind(n));
%      end
%      max(i) = nanmax(max_ind);
%      min(i) = nanmin(max_ind);
%   else
%       max(i) = (1+err).*in(i);
%       min(i) = (1-err).*in(i);
%   end
%     else
%         max(i) = NaN;
%         max(i) = NaN;
%     end
%     
%     
%     
% end

