function [marker, time] = read_neuropype_markers( filename, varargin )
% read Neuropype markers output file 
   
  f = fopen( filename, 'r' );
  if ( f == -1 )
     error( sprintf( '%s: cannot read %s', mfilename, filename ) );
  end
  
  i = 1;
  marker = []; time = [];
  
  line = fgetl(f);
  [m,t] = parse_line( line );
  marker = [""] + string( m ); % use new "string arrays" in Matlab
  time(i) = t;
  i = i+1;
  while ischar(line)
     line = fgetl(f);
     if ( line == -1 )
         break;
     end
     [m, t] = parse_line( line );
     marker(i) = string( m ); 
     time(i) = t;
     i = i+1;
  end  
  fclose( f );
   
function [m,t] = parse_line( str )
   arr = strsplit( str, ',' );
   m = strtrim( arr{1} );
   t = str2num( arr{2} );