% @brief process CSV files; creates MAT files (calls get_attention_neuropype_one_subj)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
addpath( './support/Enhanced_rdir' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
IN.PATH = 'C:\Data\fujitsu_flanker_data\';
IN.FILE_FILTER = '\**\*visual_arrest_2018-11*.xdf'

IN.SAVE_PATH = './';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
files = rdir( [IN.PATH, IN.FILE_FILTER] );

% work on CSV files
for f = 1:size( files )
   if ( f > 20 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( filepath );

   %%%{{{ IN: input files, model parameters, etc.
   IN_TMP.IN_PATH = [filepath filesep]; % fileparts doesn't add the slash at end so put it back
   IN_TMP.FREQ_OUT_FILENAME = [filename '.csv'];
   IN_TMP.MARKERS_FILENAME = [filename '_markers.csv'];
   IN_TMP.N_CHNLS = 20;
   
   IN_TMP.SAVE_PATH = IN_TMP.IN_PATH;
   IN_TMP.SAVE_FNAME = [filename '.mat'];
   %%%}}}
   
   %%%{{{ ALGO: what do w/ IN and model
   ALGO_TMP.TRACE = 0;
   ALGO_TMP.SAVE = 1;
   %%%}}}
   
   [OUT] = get_attention_neuropype_one_subj( IN_TMP, ALGO_TMP );
   
end
