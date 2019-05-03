function files = get_files( path, subjects, tasks, varargin )
% @brief find files in 'path' using 'subjects', etc. using wildcards; return is an array of strings, Nx1
   
% @todo check if subjects or tasks is just a char array; if so that will make
% length(x) the length of the string so no good
   path_as_char = char( path );
   files_as_char = [];
   
   for i = 1:length(subjects)
      for j = 1:length(tasks)
         curr_subj = char( subjects(i) );
         curr_task = char( tasks(j) );
         fname_filter = [path_as_char, '*', curr_subj, '*', curr_task, '*.mat'];
         % @todo what if task comes first
         fname_filter = char( fname_filter );
         
         curr_files = dir( fname_filter );
         for k = 1:length(curr_files)
             files_as_char = [files_as_char; string( curr_files(k).name )];
         end
      end
   end
  
   files = string( files_as_char );   