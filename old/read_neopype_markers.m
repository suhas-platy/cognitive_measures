function [marker, time] = read_neopype_markers( filename, varargin )
 
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
  
  %marker = data{1};
  %time = data{2};
  
   
   