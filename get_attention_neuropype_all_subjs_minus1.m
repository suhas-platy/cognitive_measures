% @brief make bat file which gets freq out and markers from Neuropype; run make_csv_files.cmd when done

addpath( './support' );
addpath( './support/Enhanced_rdir' );

IN.PATH = 'C:\Data\fujitsu_flanker_data\';
IN.FILE_FILTER = '\**\*.xdf';

IN.SAVE_PATH = './';
IN.SAVE_FNAME = 'make_csv_files.cmd';

fo = fopen( [IN.SAVE_PATH IN.SAVE_FNAME], 'w' );
fprintf( fo, '%s\n', 'set PYTHONHOME=' );
fprintf( fo, '%s\n', 'set "PATH=C:\Program Files\Intheon\NeuroPype Enterprise Suite (64-bit)\NeuroPype Enterprise\python;%PATH%"' );

files = rdir( [IN.PATH, IN.FILE_FILTER] );

% create CSV files
for f = 1:size( files )
   if ( f > 3 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( sprintf( 'filepath = %s', filepath ) );

   fprintf( fo, '%s\n', 'python "C:\Users\suhas\Desktop\prjs\cognitive_measures\support\FrequencyDomainPlotting_NoLSL_NoPlot_one_subj.py" ^' );
   fprintf( fo, '%s\n', sprintf( '-i "%s" ^', curr_fname ) );
   marker_filename = [filepath filesep filename '_markers.csv'];
   fprintf( fo, '%s\n', sprintf( '-m "%s" ^', marker_filename ) );
   freq_out_filename = [filepath filesep filename '.csv'];
   fprintf( fo, '%s\n\n', sprintf( '-f "%s"', freq_out_filename ) );
   
end

fclose( fo );

disp( sprintf( 'run %s when done', IN.SAVE_FNAME ) );