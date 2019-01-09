function idx = cognionics_name_to_index( name, varargin )
   lut_fname = '../conf/cognionics.json';
   
   lut = jsondecode( fileread( lut_fname ) ); % could make lut_fname a param. e.g., for q30
   
   % @todo keep lut in memory after first read (use static variable)

   for r = 1:size( lut, 1 )
      curr_name = lut(r).name;
      curr_idx = lut(r).index;
      if ( strcmp( lower(curr_name), lower(name) ) ) % can also do strcmpi
         idx = str2num( curr_idx ); return;
      end
   end   
   idx = -1; return;