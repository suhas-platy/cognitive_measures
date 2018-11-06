function [marker, time] = read_neuropype_markers( filename, varargin )
% read Neuropype markers output file 
   
  f = fopen( filename, 'r' );
  
  i = 1;
  tline = fgetl(f);
  while ischar(tline)
     %disp(tline)
     tline = fgetl(f);
     if ( tline == -1 )
         break;
     end
     tmp = textscan( tline, '%s, %f' );
     marker{i} = tmp{1};
     time{i} = tmp{2};
     i = i+1;
  end  
  fclose( f );
   
   