# NaN Median
function Y = nanmedian (X)
  k=1;
  v(k) = NaN;
  for i=1:length(X)
    if ~isnan(X(i))
      v(k) = X(i);
         k = k + 1; 
    endif
  endfor
  Y = median(v);
endfunction