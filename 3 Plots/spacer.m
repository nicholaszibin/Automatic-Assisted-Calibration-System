function [ output_arg ] = spacer( input_arg )
% This function will calculate the spacer proplery for plotting zones 

output_arg = ceil((nanmax(input_arg)-nanmin(input_arg))/3);

end

