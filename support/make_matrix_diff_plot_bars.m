function make_diff_plot_bars( pre, post, bands, anat_labels, varargin )
% pre should be 5x12, same for post
   n_bands = size(pre,1);
   n_anat_labels = size(pre,2);
   
   for i = 1:n_anat_labels
      anat_labels{i} = mt_escape_underscores( anat_labels{i} );
   end

   for i = 1:n_bands
      subplot(n_bands,1,i);
   
      foo = [pre(i,:); post(i,:)];
      bar( foo' );
      
      xticklabels( anat_labels );
      %xtickangle( 45 );
      title( bands{i} );
   end
   