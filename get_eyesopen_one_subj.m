% @brief make eyes open vs eyes closed plots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
addpath( './support/Enhanced_rdir' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
IN.PATH = 'C:\Data\Fujitsu Data Post-Testing\';
IN.FILE_FILTER = '\**\*.xdf';

IN.SAVE_PATH = './';
IN.SAVE_FNAME = '';

IN.START_CHNL = 0;
IN.END_CHNL = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
files = rdir( [IN.PATH, IN.FILE_FILTER] );

for f = 1:size( files )
   if ( f>1 )
       break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( sprintf( 'filepath = %s', filepath ) );
   
   [EEG, EEG_orig, MARKERS_orig] = load_xdf_wrapper( curr_fname );
end
