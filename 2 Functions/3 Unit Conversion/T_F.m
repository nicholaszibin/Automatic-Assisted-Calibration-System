function [ outn ] = T_F( input )
% Translates degF to degC

out = 1.8 * input + 32;

% round to 1 decimal place
for i = 1:length(input)
 outn{i} = sprintf('%.1f',out(i));

end

