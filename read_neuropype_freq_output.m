function [freq,t0,tf,delta,num_t] = read_neuropype_freq_output( filename, varargin )
% @brief read Neuropype frequency output CSV file
   
   % print the file without the header (use tail)
   temp_filename = tempname;
   CYGWIN_PATH = "C:\cygwin64\bin\";
   cmd = sprintf( '%stail -n +2 %s > %s',...
                  CYGWIN_PATH, filename, temp_filename );
   system( cmd );
   
   % read as csv
   freq = csvread( temp_filename );
   t0 = freq(1,end);
   tf = freq(end,end);
   delta_t = freq(2,end)-freq(1,end);
   num_t = tf-t0;
   
   % delete the temp file
   cmd2 = sprintf( 'rm %s', temp_filename );

   
   