function [freq,timestamp,t0,tf,delta_t,num_t] = read_neuropype_freq_output( filename, varargin )
% @brief read Neuropype frequency output CSV file

   % check inputs
   opts = cell2struct(varargin(2:2:end),varargin(1:2:end),2);   
   
   f = fopen( filename, 'r' );
   if ( f == -1 )
      error( sprintf( '%s: cannot read %s', mfilename, filename ) );
   end  
   fclose( f );
   
   % print the file without the header (use tail)
   temp_filename = tempname;
   CYGWIN_PATH = "C:\cygwin64\bin\";
   cmd = sprintf( '%stail -n +2 %s > %s',...
                  CYGWIN_PATH, filename, temp_filename );
   system( cmd );
   
   % read as csv
   freq_and_timestamp = csvread( temp_filename ); % T x N+1 (+1 is the timestamp)
   freq = freq_and_timestamp(:, 1:end-1);
   timestamp = freq_and_timestamp(:,end);
   
   t0 = timestamp(1);
   tf = timestamp(end);
   delta_t = timestamp(2)-timestamp(1);
   num_t = tf-t0;
   
   % delete the temp file
   cmd2 = sprintf( 'rm %s', temp_filename );