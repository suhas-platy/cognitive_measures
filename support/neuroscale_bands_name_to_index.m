function idx = neuroscale_bands_name_to_index( name, varargin )
% @brief given a name (e.g., FP1) return its index
   lut_fname = '../conf/bands.json';
   % assumes q20.json file is in ../conf
   curr_fname = mfilename( 'fullpath' );
   lut_fname = strrep( curr_fname, 'support\neuroscale_bands_name_to_index', 'conf\bands.json' );
   
   persistent lut;
   if ( isempty( lut ) )
     lut = jsondecode( fileread( lut_fname ) ); % could make lut_fname a param. e.g., for q30
   end
   
   % @todo keep lut in memory after first read (use static variable)

   for r = 1:size( lut, 1 )
      curr_name = lut(r).name;
      curr_idx = lut(r).index;
      if ( strcmp( lower(curr_name), lower(name) ) ) % can also do strcmpi
         idx = str2num( curr_idx ); return;
      end
   end   
   idx = -1; return;