% @brief make CMD file which gets freq out. and markers from Neuropype (frequencies usu. not used but markers are); run make_csv_files.cmd when done; uses support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py

% first run with "before" in params, then with "after"
% marker files are saved in the same place the XDF files are saved but as <filename>_markers.csv

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ handle include paths
addpath( './support' );
addpath( './support/Enhanced_rdir' );
%%%}}} eo-handle include paths

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ params (IN & ALGO)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% before
IN.PATH = 'C:\Data\Fujitsu Study Data';
IN.FILE_FILTER = '\**\*_flanker_arrows_2018-09*.xdf';

IN.SAVE_PATH = './';
IN.SAVE_FNAME = 'make_csv_files.cmd';

IN.START_CHNL = 1;
IN.END_CHNL = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% after
% IN.PATH = 'C:\Data\Fujitsu Data Post-Testing';
% IN.FILE_FILTER = '\**\*_flanker_arrows_2018-11*.xdf';

% IN.SAVE_PATH = './';
% IN.SAVE_FNAME = 'make_csv_files.cmd';

% IN.START_CHNL = 1;
% IN.END_CHNL = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ trace param's
IN
%%%}}}

%%%}}} eo-params (IN & ALGO)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ calculate
disp( ' ' );
fo = fopen( [IN.SAVE_PATH IN.SAVE_FNAME], 'w' );
fprintf( fo, '%s\n', 'set PYTHONHOME=' );
fprintf( fo, '%s\n', 'set "PATH=C:\Program Files\Intheon\NeuroPype Enterprise Suite (64-bit)\NeuroPype Enterprise\python;%PATH%"' );

files = rdir( [IN.PATH, IN.FILE_FILTER] );

% create CSV files
for f = 1:size( files )
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( sprintf( 'filepath = %s', filepath ) );

   fprintf( fo, '%s\n', 'python "C:\Users\suhas\Desktop\prjs\cognitive_measures\support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py" ^' );
   fprintf( fo, '%s\n', sprintf( '--i "%s" ^', curr_fname ) );
   marker_filename = [filepath filesep filename '_markers.csv'];
   fprintf( fo, '%s\n', sprintf( '--m "%s" ^', marker_filename ) );
   freq_out_filename = [filepath filesep filename '.csv'];
   fprintf( fo, '%s\n', sprintf( '--s "%d" ^', IN.START_CHNL ) );
   fprintf( fo, '%s\n', sprintf( '--e "%d" ^', IN.END_CHNL ) );
   fprintf( fo, '%s\n\n', sprintf( '--f "%s"', freq_out_filename ) );   
end

fclose( fo );
%%%}}} eo-calculate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%{{{ display
disp( ' ' );
disp( sprintf( 'number of subjects: %d', f ) ); 
disp( sprintf( 'run %s when done', IN.SAVE_FNAME ) );
%%%}}} eo-display