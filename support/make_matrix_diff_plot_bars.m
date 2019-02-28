function make_diff_plot_bars( pre, post, bands, from_to_labels, varargin )
% pre should be 5x12*12, same for post
   n_bands = size(pre,1);
   n_labels = size(pre,2);
   
   from_to_labels = mt_escape_underscores( from_to_labels ); % names have
                                                             % underscores in them (e.g. ant_cin_l)
   
   for i = 1:n_bands
      subplot(n_bands,1,i);
   
      foo = [pre(i,:); post(i,:)];
      bar( foo' );
      
      xticks( 1:144 );
      xticklabels( from_to_labels );
      xtickangle( 90 );
      title( bands{i} );
   end
   