addpath( './support' );
addpath( './support/Enhanced_rdir' );

IN.PATH = 'C:\Data\fujitsu_flanker_data\';
IN.FILE_FILTER = '\**\*.xdf'

files = rdir( [IN.PATH, IN.FILE_FILTER] );

% create CSV files
for f = 1:size( files )
   if ( f > 3 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( filepath );
end


% work on CSV files
for f = 1:size( files )
   if ( f > 3 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( filepath );

   %%%{{{ IN: input files, model parameters, etc.
   IN.PATH = [filepath filesep]; % fileparts doesn't add the slash at end so put it back
   IN.FREQ_OUT_FILENAME = [filename '.csv'];
   IN.MARKERS_FILENAME = [filename '_markers.csv'];
   
   IN.SAVE_PATH = IN.PATH;
   IN.SAVE_FNAME = [filename '.mat'];
   %%%}}}
   
   %%%{{{ ALGO: what do w/ IN and model
   ALGO.TRACE = 0;
   ALGO.SAVE = 1;
   %%%}}}
   
   [OUT] = test_attention_neuropype( IN, ALGO );
   
end
