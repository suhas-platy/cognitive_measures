function name = neuroscale_index_to_name( idx, varargin )
% @brief given an index (e.g., 2) return its name
   lut_fname = './conf/sources_v1.json'; % filenames are relative to where the main script is called

   % assumes json file is in ../conf
   curr_fname = mfilename( 'fullpath' );
   lut_fname = strrep( curr_fname, 'support\neuroscale_index_to_name', 'conf\sources_v1.json' );
   
   persistent lut;
   if ( isempty( lut ) )
     lut = jsondecode( fileread( lut_fname ) ); % could make lut_fname a param. e.g., for q30
   end
   
   % @todo keep lut in memory after first read (use static variable)

   % @todo could make this a binary search since idx is sorted
   for r = 1:size( lut, 1 )
      curr_name = lut(r).name;
      curr_idx = lut(r).index;
      curr_idx = str2num( curr_idx );
      if ( curr_idx == idx )
         name = curr_name; return;
      end
   end   
   name = '(not found)'; return;