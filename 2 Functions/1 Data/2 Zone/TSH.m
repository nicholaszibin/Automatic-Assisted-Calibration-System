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
## @deftypefn {Function File} {@var{retval} =} TSH (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: n_zibin <n_zibin@flame>
## Created: 2014-09-11

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TSH: Thermal and Spatial hierarchy
% For all zones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Z = TSH (Z,s_f,i_date,o_date,filen)

for f = 1:length(fieldnames(Z))
  Znum = fieldnames(Z)(f);
  for i = 1:length(Z.(Znum{:}).list.zone)
    Zzone = Z.(Znum{:}).list.zone(i);
    for n = 1:length(s_f)
      switch s_f{n}(1) % Test if the sub field is either a temperature or air flow rate field.
        case 'T'
          var = 'avg'; % Average temperatures
        case 'V' 
          var = 'sum';   % Sum air flow rates
      endswitch
      
      if ~isfield(Z.(Znum{:}).(Zzone{:}).list,(s_f{n})) % Test if the field exists
        Z.(Znum{:}).(Zzone{:}).list.(s_f{n}) = 'DNE' ;
      endif
      
      switch Z.(Znum{:}).(Zzone{:}).list.(s_f{n})
        case 'DNE'
          Z.(Znum{:}).(Zzone{:}).(s_f{n}) = 0;
        otherwise
          Z.(Znum{:}).(Zzone{:}).(s_f{n}) = database_fetch(var,Z.(Znum{:}).(Zzone{:}).list.(s_f{n}),i_date,o_date,filen);
      endswitch    
    endfor
  endfor
endfor
endfunction
