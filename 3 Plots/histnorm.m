%The function make normalized histogram, i.e. the estimation of the
%probability density function. The area of the histogram is equal one, such
%as the area bellow the theoretical PDF function. 
%You can use the output of this script to comparison of empirical data with
%the theoretical PDF for certain distribution.  
%
%INPUTs:
%data - empirical data
%bins - number of the histogram bins
%view (optional) - 1 = plot the histogram to the figure, 0 = get only values (0 is default)
%
%OUTPUTs:
%h - the normalized "height" of the histogram bars
%x - centers of bins

function [h x]=histnorm(data, bins)

    [h x] = hist(data,bins);
    h = h/sum(h);
        bar(x,h,'histc');  