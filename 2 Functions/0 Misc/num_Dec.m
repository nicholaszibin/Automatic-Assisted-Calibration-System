function [ outn ] = num_Dec( input,n )


% round to n decimal place

format = ['%.' num2str(n) 'f'];

for i = 1:length(input)
 outn{i} = sprintf(format,input(i));

end

