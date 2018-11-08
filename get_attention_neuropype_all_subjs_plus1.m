% @brief process MAT files

addpath( './support' );
addpath( './support/Enhanced_rdir' );

IN.PATH = 'C:\Data\fujitsu_flanker_data\';
IN.FILE_FILTER = '\**\*.xdf'

files = rdir( [IN.PATH, IN.FILE_FILTER] );

% work on MAT files
for f = 1:size( files )
   if ( f > 3 )
      break;
   end
   
   curr_fname = files(f).name;
   [filepath,filename,fileext] = fileparts( curr_fname );
   disp( sprintf( 'filepath = %s', filepath ) );
   
   foo = [filepath filesep filename '.mat'];
   load( foo );
   keyboard;
   
end
