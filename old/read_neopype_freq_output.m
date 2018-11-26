function [freq] = read_neopype_freq_output( filename, varargin )
 
   % print the file without the header (use tail)
   temp_filename = tempname;
   CYGWIN_PATH = "C:\cygwin64\bin\";
   cmd = sprintf( '%stail -n +2 %s > %s',...
                  CYGWIN_PATH, filename, temp_filename );
   system( cmd );
   
   % read as csv
   freq = csvread( temp_filename );
   
   % delete the temp file
   cmd2 = sprintf( 'rm %s', temp_filename );

   
   