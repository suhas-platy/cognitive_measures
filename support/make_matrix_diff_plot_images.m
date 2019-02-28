function make_diff_plot_images( pre, post, sig_inc, sig_dec, bands, from_to_labels, varargin )
% pre should be 5x12*12, same for post, sig_inc and sig_dec
   n_bands = size(pre,1);
   n_labels = size(pre,2);
   
   from_to_labels = mt_escape_underscores( from_to_labels ); % names have
                                                             % underscores in them (e.g. ant_cin_l)
   
   % first row is decreases
   for i = 1:n_bands
      subplot(2,n_bands,i);

      sig_dec_tmp = reshape( sig_dec(i,:), 12, 12 );
      imagesc( sig_dec_tmp );
      axis image;
      
      title( bands{i} );
   end
   
   % second row is increases
   for i = 1:n_bands
      subplot(2,n_bands,5+i);
      
      sig_inc_tmp = reshape( sig_inc(i,:), 12, 12 );
      imagesc( sig_inc_tmp );
      axis image;

      title( bands{i} );
   end
   
   