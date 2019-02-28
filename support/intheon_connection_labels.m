function from_to_label = intheon_connection_labels( varargin )
   for i = 1:12
      anat_label{i} = intheon_index_to_name( i );
   end
   
   ctr = 1;
   for i = 1:12
      for j = 1:12
         from_to_label{ctr} = ['From ', anat_label{i}, ' to ', anat_label{j}];
         ctr = ctr+1;
      end
   end