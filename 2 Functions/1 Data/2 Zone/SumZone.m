## Copyright (C) 2014 n_zibin
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} SumZone (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: n_zibin <n_zibin@flame>
## Created: 2014-09-12


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sums floor total air flow rates and zone total air flow rates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Z = SumZone (Z,Znum,s_f,out)
for i = 1:length(Z.(Znum{:}).list.zone)
Zzone = Z.(Znum{:}).list.zone(i);  
  for n = 1:length(s_f)
    % Floor Total
    if i == 1 && n == 1
      Z.(Znum{:}).(out{:}) = Z.(Znum{:}).(Zzone{:}).(s_f{n});
    else
      Z.(Znum{:}).(out{:}) = Z.(Znum{:}).(Zzone{:}).(s_f{n}) + Z.(Znum{:}).(out{:});
    endif 
    % Zone total 
    if n == 1  
       Z.(Znum{:}).(Zzone{:}).(out{:}) = Z.(Znum{:}).(Zzone{:}).(s_f{n});
    else
       Z.(Znum{:}).(Zzone{:}).(out{:}) = Z.(Znum{:}).(Zzone{:}).(s_f{n}) + Z.(Znum{:}).(Zzone{:}).(out{:});
    endif
    
  endfor
endfor
endfunction
